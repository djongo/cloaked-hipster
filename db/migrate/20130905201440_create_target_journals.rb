class CreateTargetJournals < ActiveRecord::Migration
  def change
    create_table :target_journals do |t|
      t.string :name

      t.timestamps
    end
  end
end
