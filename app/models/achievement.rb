class Achievement < ActiveRecord::Base
  attr_accessible :task_id, :state_id, :achieved_date, :reason, :duration

  validates_presence_of :achieved_date

  has_many :lessons
  has_many :gratefuls
  has_many :empowerments

  belongs_to :task
  #has_many :schedule, :through => :task

  UNENERGIZED = -9
  SOSO = -14

  VALID_STATE_TYPES = {
      1 => 'Happy',
      2 => 'Excited',
      3 => 'Joy',
      4 => 'Gratitude',
      5 => 'Inspired',
      6 => 'Motivated',
      7 => 'Hope',
      8 => 'Love',
      9 => 'Peace',
      10 => 'Fulfilled',
      11 => 'Achieved',
      -14 => 'So-So',
      -1 => 'Bored',
      -2 => 'Frustrated',
      -3 => 'Sad',
      -4 => 'Anger',
      -5 => 'Fear',
      -6 => 'Guilt',
      -7 => 'Shame',
      -8 => 'Embarrassed',
      -9 => 'Unenergized',
      -10 => 'Hopeless',
      -11 => 'Unachieved',
      -12 => 'Jealous',
      -13 => 'Envy'
  }

  LEVELS = {
    1 => 1..10,
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

  validates :state_id, :presence => true, :inclusion => { :in => Achievement::VALID_STATE_TYPES }
  def self.total
    self.count
  end

  def self.level
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

  def self.count_x_days_ago(x)
    self.where('achieved_date <= ?', x.days.ago).count
  end
end
