class Achievement < ActiveRecord::Base
  attr_accessible :task_id, :state_id, :achieved_date, :reason

  has_many :lessons
  has_many :gratefuls
  has_many :empowerments

  belongs_to :task
  #has_many :schedule, :through => :task

  VALID_STATE_TYPES = {
      1 => '+ Happy',
      2 => '+ Excited',
      3 => '+ Joy',
      4 => '+ Gratitude',
      5 => '+ Inspired',
      6 => '+ Motivated',
      7 => '+ Hope',
      8 => '+ Love',
      9 => '+ Peace',
      10 => '+ Fulfilled',
      -1 => '- Bored',
      -2 => '- Frustrated',
      -3 => '- Sad',
      -4 => '- Anger',
      -5 => '- Fear',
      -6 => '- Guilt',
      -7 => '- Shame',
      -8 => '- Embarrassed',
      -9 => '- Unenergized',
      -10 => '- Hopeless',
      -11 => '- Unachieved',
      -12 => '- Jealous',
      -13 => '- Envy'
  }

  UNENERGIZED = -9

  LEVELS = {
    1 => 0..10,
    2 => 11..30,
    3 => 31..50,
    4 => 51..70,
    5 => 71..100,
    6 => 101..200
  }

  def self.total
    self.count
  end

  def self.level
    level = LEVELS.select{ |_, range| range.cover? self.count }.first
    [level[0], level[1].first, level[1].last, self.count]
  end

  def self.latest_achievement_in_plan(plan_id)
    self.includes(:task).where(:tasks => {:plan_id => plan_id}).order('achieved_date desc').first
  end

  def self.achievements_on_date(date)
    self.where("date(achieved_date) = ?", date).all
  end

  def self.count_last_x_days(last_x_days)
    self.where('achieved_date > ?', DateTime.now.to_date - last_x_days.days).count
  end
end
