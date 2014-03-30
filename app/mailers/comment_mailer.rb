class CommentMailer < ActionMailer::Base
  default from: 'Happy Achiever <happyachiever-no-reply@happyachiever.com>'
  layout 'email'
  helper :page, :achievements, :gratefuls, :mailer, :plans, :layout

  def reply_email(comment, reply_to)
    @comment = comment
    @reply_to = reply_to
    mail(to: reply_to.email, subject: "You received a reply of your comment!")
  end
end
