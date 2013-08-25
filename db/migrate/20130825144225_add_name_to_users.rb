class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :roles, :integer
    add_column :users, :hbsc_member, :boolean, :default => false
  end
end
