# == Schema Information
#
# Table name: target_journals
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TargetJournal < ActiveRecord::Base
  attr_accessible :name
  has_many :publications
  validates_presence_of :name    
end
