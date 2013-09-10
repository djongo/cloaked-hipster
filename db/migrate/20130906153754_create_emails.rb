class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :trigger
      t.string :subject
      t.string :content
      t.integer :delay,	default: 0

      t.timestamps
    end
  end
end
