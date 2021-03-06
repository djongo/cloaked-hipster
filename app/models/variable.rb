# == Schema Information
#
# Table name: variables
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Variable < ActiveRecord::Base
  attr_accessible :name, :publication_ids
  validates_presence_of :name
  
  has_many :keywords
  has_many :publications, :through => :keywords
  has_many :determinants
  has_many :publications, :through => :determinants
  has_many :outcomes
  has_many :publications, :through => :outcomes
  has_many :mediators
  has_many :publications, :through => :mediators

  def self.tokens(query)
    variables = where("name ILIKE ?", "%#{query}%")
    if variables.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      variables
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(",")
  end

end
