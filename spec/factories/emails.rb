# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    trigger "MyString"
    subject "MyString"
    content "MyString"
    delay 1
  end
end