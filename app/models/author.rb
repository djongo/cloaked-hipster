# == Schema Information
#
# Table name: authors
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  publication_id  :integer
#  country_team_id :integer
#  focus_group_id  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  number          :integer
#

class Author < ActiveRecord::Base
 attr_accessible :publication_id, :name, :email, :country_team_id, 
    :focus_group_id, :country_team_name, :focus_group_name, :number
  belongs_to :publication
  acts_as_list #:scope => :publication
  belongs_to :country_team
  belongs_to :focus_group

  def country_team_name
    country_team.name if country_team
  end

  def focus_group_name
    focus_group.name if focus_group
  end
end
