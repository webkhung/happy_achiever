class TeamRequestMailer < ActionMailer::Base
  default from: 'Happy Achiever <happyachiever-no-reply@happyachiever.com>'
  layout 'email'
  helper :page, :achievements, :mailer, :layout

  def team_request_email(requester, receiver, message)
    @requester = requester
    @receiver = receiver
    @message = message
    mail(to: receiver.email, subject: "You received a team request!")
  end
end
