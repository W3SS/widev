require 'test_helper'

class MyEnvironmentControllerTest < ActionController::TestCase
  test "should get status" do
    get :status
    assert_response :success
  end

  test "should get history" do
    get :history
    assert_response :success
  end

  test "should get info" do
    get :info
    assert_response :success
  end

end
