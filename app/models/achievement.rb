class Achievement < ActiveRecord::Base
  acts_as_votable
  acts_as_commentable

  include PublicActivity::Common

  attr_accessible :task_id, :state_id, :achieved_date, :reason, :duration, :privacy

  validates_presence_of :achieved_date

  has_many :lessons, :inverse_of => :achievement
  has_many :gratefuls, :inverse_of => :achievement
  has_many :empowerments, :inverse_of => :achievement

  belongs_to :task
  belongs_to :user

  UNENERGIZED = -11
  OVERWHELMED = -14

  after_validation :modify_error

  VALID_STATE_TYPES = {
      0  => 'Journal',

      1  => 'Joy',
      2  => 'Loved',
      3  => 'Happy',
      4  => 'Peace',
      5  => 'Proud',
      6  => 'Excited',
      7  => 'Hopeful',
      8  => 'Inspired',
      9  => 'Achieved',
      10 => 'Motivated!',
      11 => 'Grateful',
      12 => 'Determined',
      13 => 'Good',
      14 => 'Outstanding',

      -1  => 'Sad',
      -2  => 'Fear',
      -3  => 'Disappointed',
      -4  => 'Bored',
      -5  => 'Angry',
      -6  => 'Guilty',
      -7  => 'Jealous',
      -8  => 'Hopeless',
      -9  => 'Unachieved',
      -10 => 'Frustrated',
      -11 => 'Unenergized',
      -12 => 'Irritated',
      -13 => 'Bad',
      -14 => 'Overwhelmed',
      -15 => 'Annoyed'
  }

  LEVELS = {
    1 => 0..10,
    2 => 11..30,
    3 => 31..60,
    4 => 61..100,
    5 => 101..150,
    6 => 151..210,
    7 => 211..280,
    8 => 281..360,
    9 => 361..450,
    10 => 451..550
  }
  SHOW_TO_ME = 0
  SHOW_TO_TEAM = 1
  SHOW_TO_PUBLIC = 2

  PRIVACY = {
      SHOW_TO_ME => 'Show this only to me',
      SHOW_TO_TEAM => 'Show this to my team',
      SHOW_TO_PUBLIC => 'Show this to public'
  }

  validates :state_id, :presence => true, :inclusion => { in: Achievement::VALID_STATE_TYPES }

  scope :achieved_before, ->(day) { where('achieved_date <= ?', day.days.ago) }

  def modify_error
    self.errors.messages[:state_id].reject!{|a|a == 'is not included in the list'} if self.errors.messages[:state_id].present?
  end

  def level
    level = LEVELS.select{ |_, range| range.cover? self.count }.first
    [level[0], level[1].first, level[1].last, self.count]
  end

  def self.last_achievement_in_plan(plan_id)
    self.includes(:task).where(:tasks => {:plan_id => plan_id}).order('achieved_date desc').first
  end

  def self.achievements_on_date(date)
    self.where("date(achieved_date) = ?", date).all
  end

  # todo: Handle timezone different.  Original DateTime.now.to_date - x.days
  def self.count_last_x_days(x)
    self.where('achieved_date > ?', x.days.ago).count
  end

  def is_state?
    self.task_id.nil?
  end

  def is_journal?
    self.state_id == 0
  end

  def journable_text
    self.reason
  end

  def self.without_journal
    where('state_id != 0')
  end

end
