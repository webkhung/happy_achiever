  class Task < ActiveRecord::Base
  attr_accessible :description, :purpose, :focus_area_id, :plan_id
  belongs_to :plan, counter_cache: true, touch: true
  belongs_to :user

  has_many :achievements
  has_many :schedules, :dependent => :destroy

  validates :description, :purpose, presence: true

  def to_s
    description
  end
end
