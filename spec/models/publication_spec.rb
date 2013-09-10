# == Schema Information
#
# Table name: publications
#
#  id                  :integer          not null, primary key
#  title               :text
#  abstract            :text
#  state               :string(255)      default("preplanned")
#  reference           :text
#  url                 :string(255)
#  change              :text
#  archived            :boolean          default(FALSE)
#  language_id         :integer          default(1)
#  publication_type_id :integer          default(1)
#  target_journal_id   :integer
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe Publication do
  pending "add some examples to (or delete) #{__FILE__}"
end
