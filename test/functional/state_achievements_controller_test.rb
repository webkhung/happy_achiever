require 'test_helper'

class StateAchievementsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => StateAchievement.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    StateAchievement.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    StateAchievement.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to state_achievement_url(assigns(:state_achievement))
  end

  def test_edit
    get :edit, :id => StateAchievement.first
    assert_template 'edit'
  end

  def test_update_invalid
    StateAchievement.any_instance.stubs(:valid?).returns(false)
    put :update, :id => StateAchievement.first
    assert_template 'edit'
  end

  def test_update_valid
    StateAchievement.any_instance.stubs(:valid?).returns(true)
    put :update, :id => StateAchievement.first
    assert_redirected_to state_achievement_url(assigns(:state_achievement))
  end

  def test_destroy
    state_achievement = StateAchievement.first
    delete :destroy, :id => state_achievement
    assert_redirected_to state_achievements_url
    assert !StateAchievement.exists?(state_achievement.id)
  end
end
