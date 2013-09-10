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

class Note < ActiveRecord::Base
  attr_accessible :publication_id, :user_id, :state, :content, :note_state
  belongs_to :publication
  belongs_to :user
  validates_presence_of :publication_id, :user_id, :state, :content

  # Need note_state because publication has state field
  
  def note_state
    state if note
  end
  
  def note_state=(input)
    self.state = Note.find_or_create_by_state(input) unless input.blank?
  end
end
