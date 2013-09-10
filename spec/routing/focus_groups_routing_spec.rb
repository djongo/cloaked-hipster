require "spec_helper"

describe FocusGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/focus_groups").should route_to("focus_groups#index")
    end

    it "routes to #new" do
      get("/focus_groups/new").should route_to("focus_groups#new")
    end

    it "routes to #show" do
      get("/focus_groups/1").should route_to("focus_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/focus_groups/1/edit").should route_to("focus_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/focus_groups").should route_to("focus_groups#create")
    end

    it "routes to #update" do
      put("/focus_groups/1").should route_to("focus_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/focus_groups/1").should route_to("focus_groups#destroy", :id => "1")
    end

  end
end
