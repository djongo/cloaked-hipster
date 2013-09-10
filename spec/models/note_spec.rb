# == Schema Information
#
# Table name: notes
#
#  id             :integer          not null, primary key
#  content        :text
#  state          :string(255)
#  publication_id :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Note do
  pending "add some examples to (or delete) #{__FILE__}"
end
