class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  scope :by_created, order: 'created_at ASC'
  scope :by_latest, order: 'created_at DESC'

  belongs_to :user

  validates_presence_of :comment

end
