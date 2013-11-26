class Plan < ActiveRecord::Base
  include SchedulesHelper
  attr_accessible :title, :vision, :purpose, :if_achieved, :if_not_achieved, :roles, :wheel_of_life, :image_url

  validates_presence_of :title, :vision, :purpose, :if_achieved, :if_not_achieved, :roles, :wheel_of_life, :image_url

  has_many :tasks, :dependent => :destroy
  has_many :focus_areas, :dependent => :destroy
  has_many :schedules, :through => :tasks
  has_many :milestones, :dependent => :destroy, :order => 'target desc'
  has_one :goal, :dependent => :destroy

  belongs_to :user

  validates :user_id, presence: true

  # todo: Switch key and value
  VALID_WHEEL_OF_LIFE_TYPES = {
      1 => 'Physical',
      2 => 'Relationship',
      3 => 'Career',
      4 => 'Finances',
      5 => 'Contribution',
      6 => 'Spiritual'
  }

  def minutes_scheduled(date = DateTime.now)
    total = 0
    temp_date = date.beginning_of_week.to_date
    while temp_date <=  date.end_of_week.to_date
      total += schedules_on_date(self.schedules, temp_date).map(&:duration).inject(0, &:+)
      temp_date += 1.day
    end

    total
  end

  def time_spent_last_week
    Achievement.includes(:task).where('tasks.plan_id = ?', self.id).where('achieved_date > ?', 1.week.ago).sum(:duration)
  end

  def last_achievement
    Achievement.last_achievement_in_plan(self.id)
  end

  # Return all schedules on a specific date
  def schedules_on(date)
    sch = self.schedules.all.select{ |s|
      s.recurrence == Schedule::RECURRENCE_TYPES[:daily] ||
      s.recurrence == Schedule::RECURRENCE_TYPES[:weekly] && s.scheduled_date.to_date.wday == date.to_date.wday ||
      s.scheduled_date.to_date == date.to_date }
    sch.sort_by!{ |s| s.scheduled_date.strftime('%H:%M:%S') }
  end
end
