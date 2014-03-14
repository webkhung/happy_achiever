class Task < ActiveRecord::Base

  STATES = %w(live archived)

  include RhodeIsland

  default_scope where(state: 'live')

  attr_accessible :description, :purpose, :focus_area_id, :plan_id

  belongs_to :plan, counter_cache: true, touch: true
  belongs_to :user
  belongs_to :focus_area

  has_many :achievements, :inverse_of => :task
  has_many :schedules, :inverse_of => :task, :dependent => :destroy

  validates :description, presence: true

  def before_entering_archived_state
    Plan.decrement_counter(:"#{self.class.name.tableize}_count", self.plan_id)
  end

  def to_s
    description
  end
end
