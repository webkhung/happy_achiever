class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  belongs_to :user

  validates_presence_of :comment

  #after_commit :send_email, :on => :create
  #
  #def send_email
  #  CommentMailer.reply_email(self, @comment.commentable.user).deliver unless current_user == self.user
  #end
end
