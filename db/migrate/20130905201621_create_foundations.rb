class CreateFoundations < ActiveRecord::Migration
  def change
    create_table :foundations do |t|
      t.integer :publication_id
      t.integer :survey_id

      t.timestamps
    end
  end
end
