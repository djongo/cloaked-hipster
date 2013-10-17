# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :author do
    name "MyString"
    email "MyString"
    number 1
    publication_id 1
    country_team_id 1
    focus_group_id 1
  end
end
