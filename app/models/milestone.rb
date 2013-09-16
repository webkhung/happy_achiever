class Milestone < ActiveRecord::Base
  attr_accessible :plan_id, :name, :target, :status

  belongs_to :plan

  STATUS = {
    0 => :not_started,
    1 => :in_progress,
    2 => :completed
  }

  def from_now
    days = (self.target.to_date - DateTime.now.to_date).to_i
    if days < 0
      "Passed #{days} days"
    else
      "#{days} days to go"
    end
  end
end
