# == Schema Information
#
# Table name: foundations
#
#  id             :integer          not null, primary key
#  publication_id :integer
#  survey_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Foundation < ActiveRecord::Base
  attr_accessible :publication_id, :survey_id, :survey_name

  belongs_to :publication
  belongs_to :survey

  def survey_name
    survey.name if survey
  end 
end
