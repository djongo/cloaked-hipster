# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
admin_user = User.find_by_email('jonasholstein@gmail.com')
admin_user.roles_mask = 3
admin_user.hbsc_member = true
admin_user.save!
puts 'user: ' << user.name

user = User.find_or_create_by_email :name => ENV['ADMIN2_NAME'].dup, :email => ENV['ADMIN2_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
admin_user = User.find_by_email(ENV['ADMIN2_EMAIL'])
admin_user.roles_mask = 3
admin_user.hbsc_member = true
admin_user.save!
puts 'user: ' << user.name

user = User.find_or_create_by_email :name => ENV['ADMIN3_NAME'].dup, :email => ENV['ADMIN3_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
admin_user = User.find_by_email(ENV['ADMIN3_EMAIL'])
admin_user.roles_mask = 3
admin_user.hbsc_member = true
admin_user.save!
puts 'user: ' << user.name

user = User.find_or_create_by_email :name => ENV['ADMIN4_NAME'].dup, :email => ENV['ADMIN4_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
admin_user = User.find_by_email(ENV['ADMIN4_EMAIL'])
admin_user.roles_mask = 3
admin_user.hbsc_member = true
admin_user.save!
puts 'user: ' << user.name

user = User.find_or_create_by_email :name => ENV['ADMIN5_NAME'].dup, :email => ENV['ADMIN5_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
admin_user = User.find_by_email(ENV['ADMIN5_EMAIL'])
admin_user.roles_mask = 3
admin_user.hbsc_member = true
admin_user.save!
puts 'user: ' << user.name

# Load languages
puts 'Languages'
["English", "Danish", "French", "German", "Spanish"].each do |language|
  Language.find_or_create_by_name(language)
end

# Load Publication Types
puts 'Publication Types'
["Undecided","Journal article","Book","Book chapter"].each do |ptype|
  PublicationType.find_or_create_by_name(ptype)
end

# Load Focus Groups
puts 'Focus Groups'
["Bullying writing group","Eating & dieting","Electronic Media Group","Family culture","Gender writing group","Medicine use writing group","Methodology Development Group","Overweight writing group","Peer culture","Physical activity","Policy Development Group","Positive health","Pubetal status & timing","Risk behaviour","School setting","Sexual health","Social inequalities","Violence & injuries"].each do |ftype|
  FocusGroup.find_or_create_by_name(ftype)
end


# Load Pages
puts 'PAGES'
if Page.find_by_title('home').nil?
  Page.create! :title => 'home', :content => 'This is the home page'
end

if Page.find_by_title('about').nil?
  Page.create! :title => 'about', :content => 'Welcome to PUMA<br />PUMA is Publication Document Management System for the HBSC research project'
end

if Page.find_by_title('contact').nil?
  Page.create! :title => 'contact', :content => 'Contact a member of the publication group for more detail'
end

if Page.find_by_title('master data').nil?
  Page.create! :title => 'master data', :content => 'This is the master data page'
end

if Page.find_by_title('no access').nil?
  Page.create! :title => 'no access', :content => 'You do not have permission to do this action!<br />Maybe you do not have a user account or your user account does not have the right permissions. Please contact the Publication Group with your username and desired access.'
end

# # Load standard email texts
puts 'Standard emails'
if Email.find_by_trigger('preplanned_submit').nil?
  Email.create! :trigger => 'preplanned_submit', :subject => 'Publication submission', :content => 'You preplanned publication has been submitted for acceptance as planned.', :delay => 0
end

if Email.find_by_trigger('preplanned_accept').nil?
  Email.create! :trigger => 'preplanned_accept', :subject => 'Publication acceptance', :content => 'You preplanned publication has been accepted as planned.', :delay => 0
end

if Email.find_by_trigger('preplanned_reject').nil?
  Email.create! :trigger => 'preplanned_reject', :subject => 'Publication rejection', :content => 'You preplanned publication has been rejected as planned.', :delay => 0
end

if Email.find_by_trigger('preplanned_remind').nil?
  Email.create! :trigger => 'preplanned_remind', :subject => 'Publication reminder', :content => 'You preplanned publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('planned_submit').nil?
  Email.create! :trigger => 'planned_submit', :subject => 'Publication submission', :content => 'You planned publication has been submitted for acceptance as in progress.', :delay => 0
end

if Email.find_by_trigger('planned_accept').nil?
  Email.create! :trigger => 'planned_accept', :subject => 'Publication acceptance', :content => 'You planned publication has been accepted as in progress.', :delay => 0
end

if Email.find_by_trigger('planned_reject').nil?
  Email.create! :trigger => 'planned_reject', :subject => 'Publication rejection', :content => 'You planned publication has been rejected as in progress.', :delay => 0
end

if Email.find_by_trigger('planned_remind').nil?
  Email.create! :trigger => 'planned_remind', :subject => 'Publication reminder', :content => 'You planned publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('inprogress_submit').nil?
  Email.create! :trigger => 'inprogress_submit', :subject => 'Publication submission', :content => 'You in progress publication has been submitted for acceptance as submitted.', :delay => 0
end

if Email.find_by_trigger('inprogress_accept').nil?
  Email.create! :trigger => 'inprogress_accept', :subject => 'Publication acceptance', :content => 'You in progress publication has been accepted as submitted.', :delay => 0
end

if Email.find_by_trigger('inprogress_reject').nil?
  Email.create! :trigger => 'inprogress_reject', :subject => 'Publication rejection', :content => 'You in progress publication has been rejected as submitted.', :delay => 0
end

if Email.find_by_trigger('inprogress_remind').nil?
  Email.create! :trigger => 'inprogress_remind', :subject => 'Publication reminder', :content => 'You in progress publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('submitted_submit').nil?
  Email.create! :trigger => 'submitted_submit', :subject => 'Publication submission', :content => 'You submitted publication has been submitted for acceptance as accepted.', :delay => 0
end

if Email.find_by_trigger('submitted_accept').nil?
  Email.create! :trigger => 'submitted_accept', :subject => 'Publication acceptance', :content => 'You submitted publication has been accepted as accepted.', :delay => 0
end

if Email.find_by_trigger('submitted_reject').nil?
  Email.create! :trigger => 'submitted_reject', :subject => 'Publication rejection', :content => 'You submitted publication has been rejected as accepted.', :delay => 0
end

if Email.find_by_trigger('submitted_remind').nil?
  Email.create! :trigger => 'submitted_remind', :subject => 'Publication reminder', :content => 'You submitted publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('accepted_submit').nil?
  Email.create! :trigger => 'accepted_submit', :subject => 'Publication submission', :content => 'You accepted publication has been submitted for acceptance as published.', :delay => 0
end

if Email.find_by_trigger('accepted_accept').nil?
  Email.create! :trigger => 'accepted_accept', :subject => 'Publication acceptance', :content => 'You accepted publication has been accepted as published.', :delay => 0
end

if Email.find_by_trigger('accepted_reject').nil?
  Email.create! :trigger => 'accepted_reject', :subject => 'Publication rejection', :content => 'You accepted publication has been rejected as published.', :delay => 0
end

if Email.find_by_trigger('accepted_remind').nil?
  Email.create! :trigger => 'accepted_remind', :subject => 'Publication reminder', :content => 'You accepted publication not been updated for a long time.', :delay => 60
end

if Email.find_by_trigger('unlock').nil?
  Email.create! :trigger => 'unlock', :subject => 'Publication acceptance', :content => 'You previously rejected publication has been accepted as preplanned.', :delay => 0
end