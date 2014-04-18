class FocusGroupsController < ApplicationController
  filter_resource_access
  # GET /focus_groups
  # GET /focus_groups.json
  def index
    @focus_groups = FocusGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @focus_groups }
    end
  end

  # GET /focus_groups/1
  # GET /focus_groups/1.json
  def show
    @focus_group = FocusGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @focus_group }
    end
  end

  # GET /focus_groups/new
  # GET /focus_groups/new.json
  def new
    @focus_group = FocusGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @focus_group }
    end
  end

  # GET /focus_groups/1/edit
  def edit
    @focus_group = FocusGroup.find(params[:id])
  end

  # POST /focus_groups
  # POST /focus_groups.json
  def create
    @focus_group = FocusGroup.new(params[:focus_group])

    respond_to do |format|
      if @focus_group.save
        format.html { redirect_to @focus_group, notice: 'Focus group was successfully created.' }
        format.json { render json: @focus_group, status: :created, location: @focus_group }
      else
        format.html { render action: "new" }
        format.json { render json: @focus_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /focus_groups/1
  # PUT /focus_groups/1.json
  def update
    @focus_group = FocusGroup.find(params[:id])

    respond_to do |format|
      if @focus_group.update_attributes(params[:focus_group])
        format.html { redirect_to @focus_group, notice: 'Focus group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @focus_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /focus_groups/1
  # DELETE /focus_groups/1.json
  def destroy
    @focus_group = FocusGroup.find(params[:id])
    @focus_group.destroy

    respond_to do |format|
      format.html { redirect_to focus_groups_url }
      format.json { head :no_content }
    end
  end
end
