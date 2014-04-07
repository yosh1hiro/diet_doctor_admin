require 'test_helper'

class CounselsControllerTest < ActionController::TestCase
  setup do
    @counsel = counsels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:counsels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create counsel" do
    assert_difference('Counsel.count') do
      post :create, counsel: {  }
    end

    assert_redirected_to counsel_path(assigns(:counsel))
  end

  test "should show counsel" do
    get :show, id: @counsel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @counsel
    assert_response :success
  end

  test "should update counsel" do
    patch :update, id: @counsel, counsel: {  }
    assert_redirected_to counsel_path(assigns(:counsel))
  end

  test "should destroy counsel" do
    assert_difference('Counsel.count', -1) do
      delete :destroy, id: @counsel
    end

    assert_redirected_to counsels_path
  end
end
