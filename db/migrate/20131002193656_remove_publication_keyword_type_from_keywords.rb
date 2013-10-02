class RemovePublicationKeywordTypeFromKeywords < ActiveRecord::Migration
  def up
    remove_column :keywords, :publication_keyword_type
  end

  def down
    add_column :keywords, :publication_keyword_type, :integer, default: 1
  end
end
