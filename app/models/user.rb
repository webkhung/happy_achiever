class User < ActiveRecord::Base
  acts_as_voter

  STATES = %w(live archived)

  include RhodeIsland

  default_scope where(state: 'live')

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :display_name, :email, :password, :password_confirmation, :remember_me

  has_many :plans, :inverse_of => :user
  has_many :achievements, :inverse_of => :user
  has_many :state_achievements, :inverse_of => :user, class_name: 'Achievement', conditions: 'task_id is null'
  has_many :task_achievements, :inverse_of => :user, class_name: 'Achievement', conditions: 'task_id is not null'
  has_many :lessons
  has_many :gratefuls, :inverse_of => :user
  has_many :schedules, :inverse_of => :user
  has_many :tasks, :inverse_of => :user
  has_many :focus_areas, :inverse_of => :user

  def level
    level = Achievement::LEVELS.select{ |_, range| range.cover? self.achievements.count }.first
    # current level, current level's min value, current level's max value, total achievements
    [level[0], level[1].first, level[1].last, self.achievements.count]
  end

  def votable_received
    plans = Plan.find_by_sql("SELECT DISTINCT plans.* FROM plans INNER JOIN votes ON votes.votable_id = plans.id AND votes.votable_type = 'Plan' WHERE plans.state = 'live' AND plans.user_id = #{self.id}").each {|p| puts p.upvotes.size }
    achievements = Achievement.find_by_sql("SELECT DISTINCT achievements.* FROM achievements INNER JOIN votes ON votes.votable_id = achievements.id AND votes.votable_type = 'Achievement' WHERE achievements.user_id = #{self.id}").each {|p| puts p.upvotes.size }

    plans.concat achievements
  end

end
