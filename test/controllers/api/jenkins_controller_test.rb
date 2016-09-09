require 'test_helper'

class Api::JenkinsControllerTest < ActionController::TestCase
  test "should get runjob" do
    get :runjob
    assert_response :success
  end

  test "should get jobinfo" do
    get :jobinfo
    assert_response :success
  end

end
