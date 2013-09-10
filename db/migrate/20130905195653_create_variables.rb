class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.string :name

      t.timestamps
    end
  end
end
