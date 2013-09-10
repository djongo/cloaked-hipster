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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @publication }
      # wicked_pdf
#       format.pdf do
#         render  :pdf => @publication.title,
# #                :template => "views/publications/publication.pdf.erb",
# #                :stylesheets => ["application","print"],
#                 :layout => "pdf.html",
#                 :page_size => 'A4'
#                 # :wkhtmltopdf  => Rails.root.join('vendor', 'wkhtmltopdf-amd64').to_s
#       end      
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
  end

  # POST /publications
  # POST /publications.json
  def create
    @publication = Publication.new(params[:publication])

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: 'Publication was successfully created.' }
        format.json { render json: @publication, status: :created, location: @publication }
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
        format.html { redirect_to @publication, notice: 'Publication was successfully updated.' }
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
    @publications = Publication.paginate(:per_page => 15, :page => params[:page])
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
