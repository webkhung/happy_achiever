require 'test_helper'

class ActionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Action.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Action.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Action.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to action_url(assigns(:action))
  end

  def test_edit
    get :edit, :id => Action.first
    assert_template 'edit'
  end

  def test_update_invalid
    Action.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Action.first
    assert_template 'edit'
  end

  def test_update_valid
    Action.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Action.first
    assert_redirected_to action_url(assigns(:action))
  end

  def test_destroy
    action = Action.first
    delete :destroy, :id => action
    assert_redirected_to actions_url
    assert !Action.exists?(action.id)
  end
end
