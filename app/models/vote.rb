class Vote < ActiveRecord::Base

  attr_accessible :votable_type, :votable_id

end
