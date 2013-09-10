class AddDefaultValueToPublicationTypeIdInPublications < ActiveRecord::Migration
  def change
  	change_column :publications, :publication_type_id, :default => 1
  	change_column :publications, :language_id, :default => 1
  end
end
