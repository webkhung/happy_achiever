class Empowerment < ActiveRecord::Base
  attr_accessible :achievement_id, :answer_1, :answer_2, :answer_3, :answer_4, :answer_5, :answer_6, :answer_7, :answer_8, :answer_9

  belongs_to :achievement
end
