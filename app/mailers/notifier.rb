class Notifier < ActionMailer::Base
  #include Devise::Mailers::Helpers

  default from: "puma.hbsc@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.workflow_notification.subject
  #
  def workflow_notification(user,email,publication)
    @content = email.content.gsub("[title]",publication.title).gsub("[id]",publication.id.to_s).gsub("[pi]",publication.user.name).gsub("[created]",publication.created_at.strftime('%Y-%m-%d')).gsub("[updated]",publication.updated_at.strftime('%Y-%m-%d')).gsub("[name]",user.name).gsub("[email]",user.email)
    mail to: user.email, subject: email.subject, date: Time.now
  end

  def test_mail(user)
    @content = "This is a test"
    mail to: "jonasholstein@gmail.com", subject: "Test email", date: Time.now
  end
end
