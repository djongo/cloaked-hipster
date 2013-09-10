class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :email
      t.integer :position
      t.integer :publication_id
      t.integer :country_team_id
      t.integer :focus_group_id

      t.timestamps
    end
  end
end
