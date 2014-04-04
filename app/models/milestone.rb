class Milestone < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  attr_accessible :plan_id, :name, :target, :measure, :status

  belongs_to :plan, counter_cache: true, touch: true

  COMPLETED = 2

  scope :completed, where(status: COMPLETED)

  STATUS = {
    0 => 'Not started',
    1 => 'In progress',
    2 => 'Completed'
  }

  def from_now
    days = (self.target.to_date - DateTime.now.to_date).to_i
    if days < 0
      "Passed #{pluralize(days, 'day')}"
    else
      "#{pluralize(days, 'day')} to go"
    end
  end

  def journable_text
    self.name
  end

end
