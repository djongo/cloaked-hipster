class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :title
      t.text :abstract
      t.string :state,              :default => 'preplanned'
      t.text :reference
      t.string :url
      t.string :change
      t.boolean :archived,          :default => false
      t.integer :language_id
      t.integer :publication_type_id
      t.integer :target_journal_id
      t.integer :user_id

      t.timestamps
    end
  end
end
