class Plan < ActiveRecord::Base
  acts_as_votable

  STATES = %w(live archived)

  include RhodeIsland
  include SchedulesHelper
  include PublicActivity::Common

  default_scope where(state: 'live')

  attr_accessible :title, :vision, :purpose, :if_not_achieved, :roles, :wheel_of_life, :image_path, :privacy, :focus_areas_attributes, :success_definition, :failure_definition, :road_block_1, :road_block_2, :road_block_3

  validates_presence_of :title, :purpose, :image_path

  has_many :tasks, :dependent => :destroy
  has_many :focus_areas, :dependent => :destroy
  has_many :schedules, :through => :tasks
  has_many :milestones, :dependent => :destroy#, :order => 'status asc, target asc'
  has_one :goal, :dependent => :destroy
  has_many :lessons, :dependent => :destroy
  has_many :achievements, :through => :tasks, :order => 'task_id, achieved_date'

  belongs_to :user

  validates :user_id, presence: true

  accepts_nested_attributes_for :focus_areas, reject_if: lambda { |a| a[:title].blank? }

  # todo: Switch key and value
  VALID_WHEEL_OF_LIFE_TYPES = {
    1 => 'Physical',
    2 => 'Relationship',
    3 => 'Career',
    4 => 'Finances',
    5 => 'Contribution',
    6 => 'Spiritual'
  }

  SHOW_GOAL_TO_PUBLIC                    = 0
  SHOW_GOAL_TITLE_PURPOSE_PIC_TO_PUBLIC  = 1
  SHOW_GOAL_TITLE_PIC_TO_PUBLIC          = 2
  SHOW_GOAL_TO_MYSELF                    = 3

  PRIVACY = {
    SHOW_GOAL_TO_PUBLIC => 'Show the goal to the public',
    SHOW_GOAL_TITLE_PURPOSE_PIC_TO_PUBLIC => 'Show the title, ultimate purpose, and picture to the public.',
    SHOW_GOAL_TITLE_PIC_TO_PUBLIC => 'Show the title and picture to the public',
    SHOW_GOAL_TO_MYSELF => 'Show to myself only',
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

  def achievements_count
    self.tasks.inject(0){ |sum, t| sum += t.achievements.count }
  end

  def upcoming_milestone
    self.milestones.where(status: 0..1).order(:target).first
  end

  def undone_tasks
    self.tasks - self.achievements.includes(:task).map(&:task).uniq
    #self.tasks.pluck(:id) - self.achievements.pluck(:task_id).uniq
  end
end
