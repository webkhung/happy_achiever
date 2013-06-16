class Plan < ActiveRecord::Base
  include SchedulesHelper
  attr_accessible :title, :vision, :purpose, :if_achieved, :if_not_achieved, :roles, :wheel_of_life, :motivation, :image_url

  has_many :tasks, :dependent => :destroy
  has_many :focus_areas, :dependent => :destroy
  has_many :schedules, :through => :tasks
  has_one :goal, :dependent => :destroy

  VALID_WHEEL_OF_LIFE_TYPES = {
      1 => 'Physical',
      2 => 'Relationship',
      3 => 'Career',
      4 => 'Finances',
      5 => 'Contribution',
      6 => 'Spiritual'
  }

  def time_scheduled(date = DateTime.now)
    total = 0
    temp_date = date.beginning_of_week.to_date
    while temp_date <=  date.end_of_week.to_date
      puts schedules_on_date(self.schedules, temp_date)
      total += schedules_on_date(self.schedules, temp_date).map(&:duration).inject(0, &:+)
      temp_date += 1.day
    end

    total
  end
end
