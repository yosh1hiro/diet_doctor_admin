require 'test_helper'

class LevelControllerTest < ActionController::TestCase
  test "should get picture" do
    get :picture
    assert_response :success
  end

end
