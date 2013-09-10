class ChangeColumnChangeInPublications < ActiveRecord::Migration
  def up
  	change_column :publications, :change, :text
  end

  def down
		change_column :publications, :change, :string
  end
end
