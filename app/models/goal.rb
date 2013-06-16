class Goal < ActiveRecord::Base
  attr_accessible :content, :plan_id
  belongs_to :plan
end
