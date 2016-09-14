require 'test_helper'

class Api::RtcControllerTest < ActionController::TestCase
  test "should get updateWorkItemByInstallation" do
    get :updateWorkItemByInstallation
    assert_response :success
  end

end
