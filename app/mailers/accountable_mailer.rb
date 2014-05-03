class AccountableMailer < ActionMailer::Base
  default from: 'Happy Achiever <happyachiever-no-reply@happyachiever.com>'
  layout 'email'
  helper :page, :achievements, :mailer, :layout

  def accountable_email(accountable, receiver)
    @accountable = accountable
    @receiver = receiver
    mail(to: receiver.email, subject: "#{@accountable.user.display_name} wants you to hold him/her accountable!")
  end
end
