require 'test_helper'

class RtcControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get get" do
    get :get
    assert_response :success
  end

end
