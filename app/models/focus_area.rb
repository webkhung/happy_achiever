class FocusArea < ActiveRecord::Base
  attr_accessible :title, :plan_id

  belongs_to :plan
  belongs_to :user

  has_many :tasks, :dependent => :destroy
end
