class VotableMailer < ActionMailer::Base
  default from: 'Happy Achiever <happyachiever-no-reply@happyachiever.com>'
  layout 'email'
  helper :page, :achievements, :gratefuls, :mailer, :plans, :layout

  def votable_email(votable, voter)
    @votable = votable
    @voter = voter
    mail(to: @votable.user.email, subject: "You received a support!")
  end
end
