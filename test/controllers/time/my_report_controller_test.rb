require 'test_helper'

class Time::MyReportControllerTest < ActionController::TestCase
  test "should get calendar" do
    get :calendar
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

end
