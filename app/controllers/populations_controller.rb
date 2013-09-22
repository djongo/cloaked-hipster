class PopulationsController < ApplicationController
  # GET /populations
  # GET /populations.json
  def index
    @populations = Population.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @populations.where("name ILIKE ?", "%#{params[:q]}%") }
    end
  end

  # GET /populations/1
  # GET /populations/1.json
  def show
    @population = Population.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @population }
    end
  end

  # GET /populations/new
  # GET /populations/new.json
  def new
    @population = Population.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @population }
    end
  end

  # GET /populations/1/edit
  def edit
    @population = Population.find(params[:id])
  end

  # POST /populations
  # POST /populations.json
  def create
    @population = Population.new(params[:population])

    respond_to do |format|
      if @population.save
        format.html { redirect_to @population, notice: 'Population was successfully created.' }
        format.json { render json: @population, status: :created, location: @population }
      else
        format.html { render action: "new" }
        format.json { render json: @population.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /populations/1
  # PUT /populations/1.json
  def update
    @population = Population.find(params[:id])

    respond_to do |format|
      if @population.update_attributes(params[:population])
        format.html { redirect_to @population, notice: 'Population was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @population.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /populations/1
  # DELETE /populations/1.json
  def destroy
    @population = Population.find(params[:id])
    @population.destroy

    respond_to do |format|
      format.html { redirect_to populations_url }
      format.json { head :no_content }
    end
  end
end
