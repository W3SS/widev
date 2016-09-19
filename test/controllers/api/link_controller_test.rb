require 'test_helper'

class Api::LinkControllerTest < ActionController::TestCase
  test "should get getByEnvironemnt" do
    get :getByEnvironemnt
    assert_response :success
  end

end
