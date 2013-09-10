class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  # def show
  #   @page = Page.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @page }
  #   end
  # end

  # GET /pages/new
  # GET /pages/new.json
  # def new
  #   @page = Page.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @page }
  #   end
  # end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  # def create
  #   @page = Page.new(params[:page])

  #   respond_to do |format|
  #     if @page.save
  #       format.html { redirect_to @page, notice: 'Page was successfully created.' }
  #       format.json { render json: @page, status: :created, location: @page }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @page.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  # def destroy
  #   @page = Page.find(params[:id])
  #   @page.destroy

  #   respond_to do |format|
  #     format.html { redirect_to pages_url }
  #     format.json { head :no_content }
  #   end
  # end

  def home
  	@title = "Home"
    @page = Page.find_by_title('home')
    
    # if user is logged in show all user's publications
    if current_user
      @publication = Publication.find_all_by_user_id(current_user.id, :order => 'updated_at DESC', :conditions => ['archived = ?', false])
    else # user not logged in so begin login
      #@user_session = UserSession.new
    end
    
    # if user is in publication group show all publications ready for 
    # acceptance or rejection
    if current_user && current_user.roles.include?("publication_group")
      @pending = Publication.find(:all, :conditions => ['state LIKE ? AND archived = ?', "%_submitted", false], :order => 'updated_at DESC')
    end
  end

  def contact
    @title = "Contact"
    @page = Page.find_by_title('contact')      	
  end

  def about
    @title = "About"
    @page = Page.find_by_title('about')  	
  end

  def master
  	if current_user #.roles.include?("publication_group")
	    @title = "Master data"
	    @page = Page.find_by_title('master data')  	
	  else
	  	redirect_to root_url, notice: "You do not have access!"
	  end
  end

end
