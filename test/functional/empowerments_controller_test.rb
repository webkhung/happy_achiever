require 'test_helper'

class EmpowermentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Empowerment.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Empowerment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Empowerment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to empowerment_url(assigns(:empowerment))
  end

  def test_edit
    get :edit, :id => Empowerment.first
    assert_template 'edit'
  end

  def test_update_invalid
    Empowerment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Empowerment.first
    assert_template 'edit'
  end

  def test_update_valid
    Empowerment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Empowerment.first
    assert_redirected_to empowerment_url(assigns(:empowerment))
  end

  def test_destroy
    empowerment = Empowerment.first
    delete :destroy, :id => empowerment
    assert_redirected_to empowerments_url
    assert !Empowerment.exists?(empowerment.id)
  end
end
