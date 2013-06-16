require 'test_helper'

class StateAchievementTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert StateAchievement.new.valid?
  end
end
