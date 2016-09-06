require 'test_helper'

class JenkinsTestControllerTest < ActionController::TestCase
  test "should get joblist" do
    get :joblist
    assert_response :success
  end

  test "should get jobstart" do
    get :jobstart
    assert_response :success
  end

end
