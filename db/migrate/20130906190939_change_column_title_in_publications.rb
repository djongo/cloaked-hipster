class ChangeColumnTitleInPublications < ActiveRecord::Migration
  def up
  	change_column :publications, :title, :text
  end

  def down
		change_column :publications, :title, :string
  end
end
