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

class Email < ActiveRecord::Base
  attr_accessible :content, :delay, :subject, :trigger
end
