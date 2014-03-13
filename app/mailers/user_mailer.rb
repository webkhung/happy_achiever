class UserMailer < ActionMailer::Base
  default from: 'Happy Achiever <happyachiever-no-reply@happyachiever.com>'
  layout 'email'
  helper :page, :achievements, :gratefuls, :user_mailer, :plans, :layout

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome")
  end

  def reminder_email(user)
    @user = user
    mail(to: @user.email, subject: "We haven't seen you in a while")
  end

  def report_email(user)
    return if user.plans.empty?

    @user = user
    mail(to: @user.email, subject: 'Happy Achiever: your goal status')
  end
end
