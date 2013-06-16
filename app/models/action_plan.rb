class ActionPlan < ActiveRecord::Base
  attr_accessible :task_id, :occurrence, :target_count, :start_date

  belongs_to :task
  has_many :schedules
end
