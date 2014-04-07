require 'test_helper'

class CounselCommentsControllerTest < ActionController::TestCase
  setup do
    @counsel_comment = counsel_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:counsel_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create counsel_comment" do
    assert_difference('CounselComment.count') do
      post :create, counsel_comment: {  }
    end

    assert_redirected_to counsel_comment_path(assigns(:counsel_comment))
  end

  test "should show counsel_comment" do
    get :show, id: @counsel_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @counsel_comment
    assert_response :success
  end

  test "should update counsel_comment" do
    patch :update, id: @counsel_comment, counsel_comment: {  }
    assert_redirected_to counsel_comment_path(assigns(:counsel_comment))
  end

  test "should destroy counsel_comment" do
    assert_difference('CounselComment.count', -1) do
      delete :destroy, id: @counsel_comment
    end

    assert_redirected_to counsel_comments_path
  end
end
