# == Schema Information
#
# Table name: authors
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  position        :integer
#  publication_id  :integer
#  country_team_id :integer
#  focus_group_id  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Author do
  pending "add some examples to (or delete) #{__FILE__}"
end
