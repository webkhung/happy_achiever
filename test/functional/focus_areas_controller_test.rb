require 'test_helper'

class FocusAreasControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => FocusArea.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    FocusArea.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    FocusArea.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to focus_area_url(assigns(:focus_area))
  end

  def test_edit
    get :edit, :id => FocusArea.first
    assert_template 'edit'
  end

  def test_update_invalid
    FocusArea.any_instance.stubs(:valid?).returns(false)
    put :update, :id => FocusArea.first
    assert_template 'edit'
  end

  def test_update_valid
    FocusArea.any_instance.stubs(:valid?).returns(true)
    put :update, :id => FocusArea.first
    assert_redirected_to focus_area_url(assigns(:focus_area))
  end

  def test_destroy
    focus_area = FocusArea.first
    delete :destroy, :id => focus_area
    assert_redirected_to focus_areas_url
    assert !FocusArea.exists?(focus_area.id)
  end
end
