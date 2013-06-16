require 'test_helper'

class ActionPlansControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => ActionPlan.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    ActionPlan.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    ActionPlan.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to action_plan_url(assigns(:action_plan))
  end

  def test_edit
    get :edit, :id => ActionPlan.first
    assert_template 'edit'
  end

  def test_update_invalid
    ActionPlan.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ActionPlan.first
    assert_template 'edit'
  end

  def test_update_valid
    ActionPlan.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ActionPlan.first
    assert_redirected_to action_plan_url(assigns(:action_plan))
  end

  def test_destroy
    action_plan = ActionPlan.first
    delete :destroy, :id => action_plan
    assert_redirected_to action_plans_url
    assert !ActionPlan.exists?(action_plan.id)
  end
end
