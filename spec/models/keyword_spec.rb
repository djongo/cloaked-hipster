# == Schema Information
#
# Table name: keywords
#
#  id             :integer          not null, primary key
#  publication_id :integer
#  variable_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Keyword do
  pending "add some examples to (or delete) #{__FILE__}"
end
