class UserMailer < ActionMailer::Base
  default from: 'Happy Achiever <happyachiever-no-reply@happyachiever.com>'
  layout 'email'
  helper :page, :achievements, :gratefuls

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome")
  end

  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: "We haven't seen you in a while")
  end
end
