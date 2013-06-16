  class Task < ActiveRecord::Base
  attr_accessible :description, :purpose, :focus_area_id, :plan_id
  belongs_to :plan

  has_many :achievements
  has_many :schedules, :dependent => :destroy

  def to_s
    description
  end
end
