require 'test_helper'

class GratefulsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Grateful.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Grateful.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Grateful.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to grateful_url(assigns(:grateful))
  end

  def test_edit
    get :edit, :id => Grateful.first
    assert_template 'edit'
  end

  def test_update_invalid
    Grateful.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Grateful.first
    assert_template 'edit'
  end

  def test_update_valid
    Grateful.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Grateful.first
    assert_redirected_to grateful_url(assigns(:grateful))
  end

  def test_destroy
    grateful = Grateful.first
    delete :destroy, :id => grateful
    assert_redirected_to gratefuls_url
    assert !Grateful.exists?(grateful.id)
  end
end
