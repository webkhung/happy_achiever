require 'test_helper'

class ActionPlanTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ActionPlan.new.valid?
  end
end
