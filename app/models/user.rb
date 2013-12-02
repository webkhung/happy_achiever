class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :plans
  has_many :achievements
  has_many :lessons
  has_many :gratefuls
  has_many :schedules
  has_many :tasks
  has_many :focus_areas

  def level
    level = Achievement::LEVELS.select{ |_, range| range.cover? self.achievements.count }.first
    # current level, current level's min value, current level's max value, total achievements
    [level[0], level[1].first, level[1].last, self.achievements.count]
  end
end
