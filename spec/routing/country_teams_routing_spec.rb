require "spec_helper"

describe CountryTeamsController do
  describe "routing" do

    it "routes to #index" do
      get("/country_teams").should route_to("country_teams#index")
    end

    it "routes to #new" do
      get("/country_teams/new").should route_to("country_teams#new")
    end

    it "routes to #show" do
      get("/country_teams/1").should route_to("country_teams#show", :id => "1")
    end

    it "routes to #edit" do
      get("/country_teams/1/edit").should route_to("country_teams#edit", :id => "1")
    end

    it "routes to #create" do
      post("/country_teams").should route_to("country_teams#create")
    end

    it "routes to #update" do
      put("/country_teams/1").should route_to("country_teams#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/country_teams/1").should route_to("country_teams#destroy", :id => "1")
    end

  end
end
