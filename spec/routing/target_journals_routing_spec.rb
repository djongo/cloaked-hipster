require "spec_helper"

describe TargetJournalsController do
  describe "routing" do

    it "routes to #index" do
      get("/target_journals").should route_to("target_journals#index")
    end

    it "routes to #new" do
      get("/target_journals/new").should route_to("target_journals#new")
    end

    it "routes to #show" do
      get("/target_journals/1").should route_to("target_journals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/target_journals/1/edit").should route_to("target_journals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/target_journals").should route_to("target_journals#create")
    end

    it "routes to #update" do
      put("/target_journals/1").should route_to("target_journals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/target_journals/1").should route_to("target_journals#destroy", :id => "1")
    end

  end
end
