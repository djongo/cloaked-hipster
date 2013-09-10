# == Schema Information
#
# Table name: country_teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CountryTeam < ActiveRecord::Base
  attr_accessible :name
end
