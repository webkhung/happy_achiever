require 'test_helper'

class AreaOfFocusControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => AreaOfFocus.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    AreaOfFocus.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    AreaOfFocus.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to area_of_focus_url(assigns(:area_of_focus))
  end

  def test_edit
    get :edit, :id => AreaOfFocus.first
    assert_template 'edit'
  end

  def test_update_invalid
    AreaOfFocus.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AreaOfFocus.first
    assert_template 'edit'
  end

  def test_update_valid
    AreaOfFocus.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AreaOfFocus.first
    assert_redirected_to area_of_focus_url(assigns(:area_of_focus))
  end

  def test_destroy
    area_of_focus = AreaOfFocus.first
    delete :destroy, :id => area_of_focus
    assert_redirected_to area_of_focus_url
    assert !AreaOfFocus.exists?(area_of_focus.id)
  end
end
