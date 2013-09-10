# == Schema Information
#
# Table name: determinants
#
#  id             :integer          not null, primary key
#  publication_id :integer
#  variable_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Determinant < ActiveRecord::Base
  attr_accessible :publication_id, :variable_id,:variable_name
  belongs_to :publication
  belongs_to :variable

  def variable_name
    variable.name if variable
  end

  def variable_name=(name)
    self.variable = Variable.find_or_create_by_name(name) unless name.blank?
  end

end
