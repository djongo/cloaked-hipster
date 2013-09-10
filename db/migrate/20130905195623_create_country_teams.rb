class CreateCountryTeams < ActiveRecord::Migration
  def change
    create_table :country_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
