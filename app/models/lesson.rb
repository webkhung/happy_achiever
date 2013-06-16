class Lesson < ActiveRecord::Base
  attr_accessible :category, :note

  belongs_to :achievement
  belongs_to :plan

  def self.categories(plan_id)
    self.where(:plan_id => plan_id).pluck(:category).uniq
  end

  def self.count_last_x_days(last_x_days)
    self.joins(:achievement).where('achieved_date > ?', DateTime.now.to_date - last_x_days.days).count
  end
end
