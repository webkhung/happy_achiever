class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  belongs_to :user

  validates_presence_of :comment

  after_commit :send_email, :on => :create

  def send_email
    CommentMailer.comment_email(self).deliver
  end
end
