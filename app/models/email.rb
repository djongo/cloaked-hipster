class Email < ActiveRecord::Base
  attr_accessible :content, :delay, :subject, :trigger
end
