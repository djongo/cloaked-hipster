require "spec_helper"

describe PopulationsController do
  describe "routing" do

    it "routes to #index" do
      get("/populations").should route_to("populations#index")
    end

    it "routes to #new" do
      get("/populations/new").should route_to("populations#new")
    end

    it "routes to #show" do
      get("/populations/1").should route_to("populations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/populations/1/edit").should route_to("populations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/populations").should route_to("populations#create")
    end

    it "routes to #update" do
      put("/populations/1").should route_to("populations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/populations/1").should route_to("populations#destroy", :id => "1")
    end

  end
end
