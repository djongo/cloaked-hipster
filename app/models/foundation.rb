class Foundation < ActiveRecord::Base
  attr_accessible :publication_id, :survey_id, :survey_name

  belongs_to :publication
  belongs_to :survey

  def survey_name
    survey.name if survey
  end 
end
