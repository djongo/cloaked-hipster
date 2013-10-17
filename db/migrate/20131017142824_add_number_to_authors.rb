class AddNumberToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :number, :integer
  end
end
