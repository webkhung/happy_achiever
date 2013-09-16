require 'test_helper'

class MilestonesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Milestone.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Milestone.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Milestone.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to milestone_url(assigns(:milestone))
  end

  def test_edit
    get :edit, :id => Milestone.first
    assert_template 'edit'
  end

  def test_update_invalid
    Milestone.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Milestone.first
    assert_template 'edit'
  end

  def test_update_valid
    Milestone.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Milestone.first
    assert_redirected_to milestone_url(assigns(:milestone))
  end

  def test_destroy
    milestone = Milestone.first
    delete :destroy, :id => milestone
    assert_redirected_to milestones_url
    assert !Milestone.exists?(milestone.id)
  end
end
