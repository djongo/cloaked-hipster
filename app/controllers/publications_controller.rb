class PublicationsController < ApplicationController
  # GET /publications
  # GET /publications.json

  # auto_complete_for :variable, :name
  # auto_complete_for :target_journal, :name
  def index
    # @publications = Publication.all
    @publications = Publication.find(:all, :conditions => ['archived = ?', false])
    @per_page = params[:per_page] || 5

    if(params[:search]).blank?
      @publications = Publication.paginate(:page => params[:page], :per_page => @per_page, :order => 'title', :conditions => ['archived = ?', false])
      @export = Publication.find(:all, :order => 'title', :conditions => ['archived = ?', false])
    else
      # changes for thinking sphinx
      @publications = Publication.search params[:search], 
            :page => params[:page], 
            :per_page => @per_page, 
            :match_mode => :boolean,
            :field_weights => {
              :title => 20,
              :keyword_name => 10,
              :variable_name => 5
              }
      @export = Publication.search params[:search],
              :match_mode => :boolean,
              :field_weights => {
                :title => 20,
                :keyword_name => 10,
                :variable_name => 5
              }
    end              

    # No match for your search criteria    
    if @publications.empty?
      flash[:error] = "No publications matched your search criteria."
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @publications }
      format.csv { send_data Publication.to_csv(@export) }
      format.xls { send_data Publication.to_csv(@export, 
        {col_sep: "\t", encoding: "UTF-8" } ) } 
    end
  end

  # GET /publications/1
  # GET /publications/1.json
  def show
    @publication = Publication.find(params[:id])

    # Get previous version if requested
    if params[:version]
      @version = @publication.versions.find(params[:version])
      @publication = @version.reify

      # get hmt from meta data in versions table if available
      if !@version.keywords.nil?
        @keywords = Variable.find(YAML.load(@version.keywords))
      else
        @keywords = []
      end

      if !@version.mediators.nil?
        @mediators = Keyword.find(YAML.load(@version.mediators))
      else
        @mediators = []
      end

      if !@version.outcomes.nil?
        @outcomes = Keyword.find(YAML.load(@version.outcomes))
      else 
        @outcomes = []
      end

      if !@version.determinants.nil?
        @determinants = Keyword.find(YAML.load(@version.determinants))
      else 
        @determinants = []
      end 

      if !@version.inclusions.nil?
        @inclusions = Inclusion.find(YAML.load(@version.inclusions))
      else 
        @inclusions = []
      end 

      if !@version.foundations.nil?
        @foundations = Foundation.find(YAML.load(@version.foundations))
      else 
        @foundations = []
      end 

    else # setting them here to get least work in view
      @keywords = @publication.keywords.map{|k| Variable.find(k.variable_id)}
      @mediators = @publication.mediators.map{|k| Variable.find(k.variable_id)}
      @outcomes = @publication.outcomes.map{|k| Variable.find(k.variable_id)}
      @determinants = @publication.determinants.map{|k| Variable.find(k.variable_id)}
      @inclusions = @publication.inclusions
      @foundations = @publication.foundations
    end

    # respond to format, mostly for pdf rendering
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @publication }
      # wicked_pdf
      format.pdf do
        render  :pdf => @publication.title,
               template: "publications/publication.pdf.erb",
#                :stylesheets => ["application","print"],
                # :layout => "pdf.html",
                page_size: 'A4',
                disposition: 'inline',
                orientation: 'Landscape'
                # :wkhtmltopdf  => Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s
      end      
    end
  end

  # GET /publications/new
  # GET /publications/new.json
  def new
    @publication = Publication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @publication }
    end
  end

  # GET /publications/1/edit
  def edit
    @publication = Publication.find(params[:id])
    @publication.change = ""
    if (@publication.state == "preplanned_submitted" || 
        @publication.state == "planned_submitted" || 
        @publication.state == "inprogress_submitted" || 
        @publication.state == "submitted_submitted" || 
        @publication.state == "accepted_submitted") && 
        !current_user.roles.include?("publication_group")
      redirect_to @publication, notice: "Publication has been submitted and cannot be edited."
    end
    if @publication.archived 
      redirect_to @publication, notice: "Publication is archived and cannot be edited."
    end    
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(params[:publication])

    respond_to do |format|
      if @publication.save
        if params[:save_and_submit]
          @publication.preplanned_submit!
          format.html { redirect_to @publication, 
             notice: 'Publication was successfully created and submitted to the publication group.' }
        else
          format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
          format.json { render json: @publication, status: :created, location: @publication }
        end 
      else
        format.html { render action: "new" }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /publications/1
  # PUT /publications/1.json
  def update
    @publication = Publication.find(params[:id])

    respond_to do |format|
      if @publication.update_attributes(params[:publication])
        format.html { redirect_to @publication, notice: 'Publication was successfully updated. Please note that it has been submitted to the publication group.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.json
  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to publications_url }
      format.json { head :no_content }
    end
  end

  def list
    @publications = Publication.order(:id) #.paginate(:per_page => 15, :page => params[:page])
  end

  def archive
    @publication = Publication.find(params[:id])
    @publication.update_attribute :archived, true
    redirect_to list_publications_path, notice: "Publication archived."
  end
  
  def unarchive
    @publication = Publication.find(params[:id])
    @publication.update_attribute :archived, false
    redirect_to list_publications_path, notice: "Publication removed from archive to active status."
  end

  # Import
  def import
    # begin
      Publication.import(params[:file])
      flash[:notice] = "Publications imported."
    # rescue
    #   flash[:error] = "Error in data. Check your import file."
    # end
    redirect_to list_publications_url
  end

  # Workflow via aasm functions below  
  # locking to avoid concurrency issues, see
  # http://www.engineyard.com/blog/2010/concurrency-and-the-aasm-gem/

  # preplanned to planned
  def preplanned_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_submit!
    flash[:notice] = "Preplanned submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('preplanned_submit')
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def preplanned_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_accept!
    flash[:notice] = "Publication accepted as planned. Email sent to the author."
    @email = Email.find_by_trigger('preplanned_accept')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def preplanned_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_reject!
    flash[:error] = "Preplanned publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('preplanned_reject')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def preplanned_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.preplanned_remind!
    @email = Email.find_by_trigger('preplanned_remind')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    flash[:notice] = "Pre planned publication hbsc responsible author reminder sent."
    redirect_to list_publications_path       
  end

  # planned to inprogress
  def planned_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_submit!
    flash[:notice] = "Planned submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('planned_submit')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def planned_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_accept!
    flash[:notice] = "Publication accepted as in progress. Email sent to the author."
    @email = Email.find_by_trigger('planned_accept')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def planned_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_reject!
    flash[:error] = "Planned publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('planned_reject')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end    

  def planned_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.planned_remind!
    @email = Email.find_by_trigger('planned_remind')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    flash[:notice] = "Planned publication hbsc responsible author reminder sent."
    redirect_to list_publications_path    
  end
      
  # inprogress to submitted
  def inprogress_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_submit!
    flash[:notice] = "In progress submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('inprogress_submit')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def inprogress_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_accept!
    flash[:notice] = "Publication accepted as submitted. Email sent to the author."
    @email = Email.find_by_trigger('inprogress_accept')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def inprogress_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_reject!
    flash[:error] = "In progress publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('inprogress_reject')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end   

  def inprogress_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.inprogress_remind!
    @email = Email.find_by_trigger('inprogress_remind')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    flash[:notice] = "In progress publication hbsc responsible author reminder sent."
    redirect_to list_publications_path    
  end    

  # submitted to accepted
  def submitted_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_submit!
    flash[:notice] = "Submitted submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('submitted_submit')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def submitted_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_accept!
    flash[:notice] = "Publication accepted as accepted. Email sent to the author."
    @email = Email.find_by_trigger('submitted_accept')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def submitted_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_reject!
    flash[:error] = "Submitted publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('submitted_reject')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end   

  def submitted_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.submitted_remind!
    @email = Email.find_by_trigger('submitted_remind')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    flash[:notice] = "Submitted publication hbsc responsible author reminder sent."
    redirect_to list_publications_path      
  end 

  # accepted to published
  def accepted_submit
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_submit!
    flash[:notice] = "Accepted submitted for acceptance. Email sent to the author."
    @email = Email.find_by_trigger('accepted_submit')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def accepted_accept
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_accept!
    flash[:notice] = "Accepted accepted as published. Email sent to the author."
    @email = Email.find_by_trigger('accepted_accept')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end
  
  def accepted_reject
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_reject!
    flash[:error] = "Accepted publication rejected. Email sent to the author."
    @email = Email.find_by_trigger('accepted_reject')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url
  end   

  def accepted_remind
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.accepted_remind!
    @email = Email.find_by_trigger('accepted_remind')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    flash[:notice] = "Accepted publication hbsc responsible author reminder sent."  
    redirect_to list_publications_path    
  end 

  # rescue publication from rejected preplanned
  def unlock
    @publication = Publication.find(params[:id])
    @publication.lock!
    @publication.unlock!
    flash[:notice] = "Previously rejected publication accepted as preplanned. Email sent to the author."
    @email = Email.find_by_trigger('unlock')    
    Notifier.workflow_notification(@publication.user,@email,@publication).deliver
    redirect_to publication_url    
  end
  private

  def export_options
      @export_options ||= { 
              :columns => [ :id, 
                            :title, 
                            :created_at, 
                            :updated_at, 
                            :keywords_xls,                          
                            {:language => [:name]},
                            {:publication_type => [:name]},
                            :abstract,
                            {:user => [:name]},
                            :surveys_xls,
                            :populations_xls,
                            :outcomes_xls,
                            :determinants_xls,
                            :mediators_xls,
                            {:target_journal => [:name]},
                            :url,
                            :promotion,
                            :reference,
                            :state
                            ], 
              :headers => [ 'ID',
                            'Title', 
                            'Created At',
                            'Updated At',
                            'Keywords',                          
                            'Language',
                            'Publication Type',
                            'Abstract',
                            'First Author',
                            'Survey Data',
                            'Populations',
                            'Outcome Measures',
                            'Determinants',
                            'Confounders/Mediators',
                            'Target Journal',
                            'URL',
                            'Promotion',
                            'Reference/Citation',
                            'State']
            }
    end

end
