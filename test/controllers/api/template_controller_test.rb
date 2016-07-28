require 'test_helper'

class Api::TemplateControllerTest < ActionController::TestCase
  test "should get getavailablesteps" do
    get :getavailablesteps
    assert_response :success
  end

  test "should get getstepfortemplate" do
    get :getstepfortemplate
    assert_response :success
  end

  test "should get addsteptotemplate" do
    get :addsteptotemplate
    assert_response :success
  end

  test "should get removestepfromtemplate" do
    get :removestepfromtemplate
    assert_response :success
  end

end
