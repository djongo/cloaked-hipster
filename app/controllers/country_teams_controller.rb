class CountryTeamsController < ApplicationController
  # GET /country_teams
  # GET /country_teams.json
  def index
    @country_teams = CountryTeam.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @country_teams }
    end
  end

  # GET /country_teams/1
  # GET /country_teams/1.json
  def show
    @country_team = CountryTeam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country_team }
    end
  end

  # GET /country_teams/new
  # GET /country_teams/new.json
  def new
    @country_team = CountryTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @country_team }
    end
  end

  # GET /country_teams/1/edit
  def edit
    @country_team = CountryTeam.find(params[:id])
  end

  # POST /country_teams
  # POST /country_teams.json
  def create
    @country_team = CountryTeam.new(params[:country_team])

    respond_to do |format|
      if @country_team.save
        format.html { redirect_to @country_team, notice: 'Country team was successfully created.' }
        format.json { render json: @country_team, status: :created, location: @country_team }
      else
        format.html { render action: "new" }
        format.json { render json: @country_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /country_teams/1
  # PUT /country_teams/1.json
  def update
    @country_team = CountryTeam.find(params[:id])

    respond_to do |format|
      if @country_team.update_attributes(params[:country_team])
        format.html { redirect_to @country_team, notice: 'Country team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @country_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /country_teams/1
  # DELETE /country_teams/1.json
  def destroy
    @country_team = CountryTeam.find(params[:id])
    @country_team.destroy

    respond_to do |format|
      format.html { redirect_to country_teams_url }
      format.json { head :no_content }
    end
  end
end
