# == Schema Information
#
# Table name: publication_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PublicationType < ActiveRecord::Base
  attr_accessible :name
  has_many :publications
  validates_presence_of :name    
end
