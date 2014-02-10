class Lesson < ActiveRecord::Base
  attr_accessible :category, :note

  belongs_to :achievement
  belongs_to :plan

  validates :note, presence: true

  def self.categories(plan_id)
    self.where(:plan_id => plan_id).pluck(:category).uniq
  end

  def self.count_last_x_days(x)
    self.joins(:achievement).where('achieved_date > ?', DateTime.now.to_date - x.days).count
  end

  def self.count_x_days_ago(x)
    self.joins(:achievement).where('achieved_date <= ?', DateTime.now.to_date - x.days).count
  end
end
