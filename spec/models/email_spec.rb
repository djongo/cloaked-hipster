# == Schema Information
#
# Table name: emails
#
#  id         :integer          not null, primary key
#  trigger    :string(255)
#  subject    :string(255)
#  content    :string(255)
#  delay      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Email do
  pending "add some examples to (or delete) #{__FILE__}"
end
