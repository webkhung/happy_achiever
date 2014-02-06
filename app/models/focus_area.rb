class FocusArea < ActiveRecord::Base

  STATES = %w(live archived)

  include RhodeIsland

  default_scope where(state: 'live')

  attr_accessible :title, :plan_id, :tasks_attributes

  belongs_to :plan
  belongs_to :user

  has_many :tasks, :dependent => :destroy

  accepts_nested_attributes_for :tasks, reject_if: lambda { |a| a[:description].blank? }

  before_save :set_task

  def set_task
    self.tasks.each {|t| t.plan_id = self.plan_id}
  end

end
