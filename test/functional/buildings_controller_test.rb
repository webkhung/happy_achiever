require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Building.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Building.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to buildings_url
  end
end
