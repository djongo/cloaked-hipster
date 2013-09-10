class CreateInclusions < ActiveRecord::Migration
  def change
    create_table :inclusions do |t|
      t.integer :publication_id
      t.integer :population_id

      t.timestamps
    end
  end
end
