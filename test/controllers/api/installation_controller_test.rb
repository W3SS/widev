require 'test_helper'

class Api::InstallationControllerTest < ActionController::TestCase
  test "should get startTask" do
    get :startTask
    assert_response :success
  end

  test "should get endTask" do
    get :endTask
    assert_response :success
  end

  test "should get errorTask" do
    get :errorTask
    assert_response :success
  end

end
