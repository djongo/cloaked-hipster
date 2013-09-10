# == Schema Information
#
# Table name: inclusions
#
#  id             :integer          not null, primary key
#  publication_id :integer
#  population_id  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Inclusion < ActiveRecord::Base
  attr_accessible :population_id, :publication_id, :population_name

  belongs_to :publication
  belongs_to :population

  def population_name
    population.name if population
  end

  def population_name=(name)
    self.population = Variable.find_or_create_by_name(name) unless name.blank?
  end  
end
