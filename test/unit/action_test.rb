require 'test_helper'

class ActionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Action.new.valid?
  end
end
