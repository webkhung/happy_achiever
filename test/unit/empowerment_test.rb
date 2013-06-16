require 'test_helper'

class EmpowermentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Empowerment.new.valid?
  end
end
