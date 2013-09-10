class CreateMediators < ActiveRecord::Migration
  def change
    create_table :mediators do |t|
      t.integer :publication_id
      t.integer :variable_id

      t.timestamps
    end
  end
end
