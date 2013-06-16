require 'test_helper'

class AreaOfFocusTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert AreaOfFocus.new.valid?
  end
end
