class Accountable < ActiveRecord::Base
  acts_as_votable
  acts_as_commentable

  attr_accessible :user_id, :description, :message, :frequency, :end_date

  belongs_to :user

  validates_presence_of :description, :message, :end_date
end
