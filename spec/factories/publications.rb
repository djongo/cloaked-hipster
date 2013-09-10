# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :publication do
    title "MyString"
    abstract "MyText"
    state "MyString"
    reference "MyText"
    url "MyString"
    change "MyString"
    archived false
    language_id 1
    publication_type_id 1
    target_journal_id 1
    user_id 1
  end
end
