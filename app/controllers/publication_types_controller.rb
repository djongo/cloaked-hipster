class PublicationTypesController < ApplicationController
  # GET /publication_types
  # GET /publication_types.json
  def index
    @publication_types = PublicationType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @publication_types }
    end
  end

  # GET /publication_types/1
  # GET /publication_types/1.json
  def show
    @publication_type = PublicationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @publication_type }
    end
  end

  # GET /publication_types/new
  # GET /publication_types/new.json
  def new
    @publication_type = PublicationType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @publication_type }
    end
  end

  # GET /publication_types/1/edit
  def edit
    @publication_type = PublicationType.find(params[:id])
  end

  # POST /publication_types
  # POST /publication_types.json
  def create
    @publication_type = PublicationType.new(params[:publication_type])

    respond_to do |format|
      if @publication_type.save
        format.html { redirect_to @publication_type, notice: 'Publication type was successfully created.' }
        format.json { render json: @publication_type, status: :created, location: @publication_type }
      else
        format.html { render action: "new" }
        format.json { render json: @publication_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /publication_types/1
  # PUT /publication_types/1.json
  def update
    @publication_type = PublicationType.find(params[:id])

    respond_to do |format|
      if @publication_type.update_attributes(params[:publication_type])
        format.html { redirect_to @publication_type, notice: 'Publication type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @publication_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publication_types/1
  # DELETE /publication_types/1.json
  def destroy
    @publication_type = PublicationType.find(params[:id])
    @publication_type.destroy

    respond_to do |format|
      format.html { redirect_to publication_types_url }
      format.json { head :no_content }
    end
  end
end
