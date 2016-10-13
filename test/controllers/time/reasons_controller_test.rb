require 'test_helper'

class Time::ReasonsControllerTest < ActionController::TestCase
  setup do
    @time_reason = time_reasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_reasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_reason" do
    assert_difference('Time::Reason.count') do
      post :create, time_reason: { name: @time_reason.name }
    end

    assert_redirected_to time_reason_path(assigns(:time_reason))
  end

  test "should show time_reason" do
    get :show, id: @time_reason
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_reason
    assert_response :success
  end

  test "should update time_reason" do
    patch :update, id: @time_reason, time_reason: { name: @time_reason.name }
    assert_redirected_to time_reason_path(assigns(:time_reason))
  end

  test "should destroy time_reason" do
    assert_difference('Time::Reason.count', -1) do
      delete :destroy, id: @time_reason
    end

    assert_redirected_to time_reasons_path
  end
end
