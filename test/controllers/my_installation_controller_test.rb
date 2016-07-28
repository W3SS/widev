require 'test_helper'

class MyInstallationControllerTest < ActionController::TestCase
  test "should get newinstall" do
    get :newinstall
    assert_response :success
  end

  test "should get createinstall" do
    get :createinstall
    assert_response :success
  end

end
