class TeamMembership < ActiveRecord::Base
  attr_accessible :user_id, :teammate_user_id

  belongs_to :team_member, class_name: 'User', :foreign_key => :teammate_user_id
  belongs_to :owner, class_name: 'User', :foreign_key => :user_id
end

