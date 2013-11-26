class Grateful < ActiveRecord::Base

  attr_accessible :achievement_id, :grateful_1, :grateful_2, :grateful_3, :grateful_4, :grateful_5

  belongs_to :achievement

  def self.all_gratefuls
    arr = []
    Grateful.all.each {|g| arr << g.grateful_1 << g.grateful_2 << g.grateful_3 << g.grateful_4 << g.grateful_5 }
    arr.reject!{ |r|r.blank? }.uniq
  end
end
