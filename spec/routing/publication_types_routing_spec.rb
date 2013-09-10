require "spec_helper"

describe PublicationTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/publication_types").should route_to("publication_types#index")
    end

    it "routes to #new" do
      get("/publication_types/new").should route_to("publication_types#new")
    end

    it "routes to #show" do
      get("/publication_types/1").should route_to("publication_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/publication_types/1/edit").should route_to("publication_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/publication_types").should route_to("publication_types#create")
    end

    it "routes to #update" do
      put("/publication_types/1").should route_to("publication_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/publication_types/1").should route_to("publication_types#destroy", :id => "1")
    end

  end
end
