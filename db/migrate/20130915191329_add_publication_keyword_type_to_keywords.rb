class AddPublicationKeywordTypeToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :publication_keyword_type, :integer, default: 1
  end
end
