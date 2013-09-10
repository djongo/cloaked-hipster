# == Schema Information
#
# Table name: populations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Population < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name  
end
