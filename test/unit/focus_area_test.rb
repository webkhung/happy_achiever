require 'test_helper'

class FocusAreaTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FocusArea.new.valid?
  end
end
