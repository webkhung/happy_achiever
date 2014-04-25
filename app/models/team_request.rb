class TeamRequest < ActiveRecord::Base

  attr_accessible :requester_user_id, :receiver_user_id, :message, :accepted_on

  validates_presence_of :requester_user_id, :receiver_user_id

  belongs_to :requester, class_name: 'User', foreign_key: :requester_user_id
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_user_id

  REQUEST_STATUS = {
    waiting: 0,
    accepted: 1,
    denied: 2
  }

end
