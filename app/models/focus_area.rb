class FocusArea < ActiveRecord::Base
  attr_accessible :title, :plan_id

  belongs_to :plan
  has_many :tasks, :dependent => :destroy
end
