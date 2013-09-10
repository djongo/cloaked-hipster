class CreateFocusGroups < ActiveRecord::Migration
  def change
    create_table :focus_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
