class Keyword < ActiveRecord::Base
  attr_accessible :publication_id, :variable_id, :variable_name
  belongs_to :publication
  belongs_to :variable

  
  def variable_name
    variable.name if variable
  end

  def variable_name=(name)
    self.variable = Variable.find_or_create_by_name(name) unless name.blank?
  end  

  def self.ids_from_tokens(tokens, pub_id)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(variable_name: $1, publication_id: pub_id).id }
    tokens.split(",")
  end
end
