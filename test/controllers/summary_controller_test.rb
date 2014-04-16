require 'test_helper'

class SummaryControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get count" do
    get :count
    assert_response :success
  end

  test "should get cumulative_user" do
    get :cumulative_user
    assert_response :success
  end

  test "should get unique_user" do
    get :unique_user
    assert_response :success
  end

end
