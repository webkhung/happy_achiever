require 'test_helper'

class MilestoneTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Milestone.new.valid?
  end
end
