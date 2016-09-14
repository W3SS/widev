require 'test_helper'

class RtcInfosControllerTest < ActionController::TestCase
  setup do
    @rtc_info = rtc_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rtc_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rtc_info" do
    assert_difference('RtcInfo.count') do
      post :create, rtc_info: { password: @rtc_info.password, user_id: @rtc_info.user_id, username: @rtc_info.username }
    end

    assert_redirected_to rtc_info_path(assigns(:rtc_info))
  end

  test "should show rtc_info" do
    get :show, id: @rtc_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rtc_info
    assert_response :success
  end

  test "should update rtc_info" do
    patch :update, id: @rtc_info, rtc_info: { password: @rtc_info.password, user_id: @rtc_info.user_id, username: @rtc_info.username }
    assert_redirected_to rtc_info_path(assigns(:rtc_info))
  end

  test "should destroy rtc_info" do
    assert_difference('RtcInfo.count', -1) do
      delete :destroy, id: @rtc_info
    end

    assert_redirected_to rtc_infos_path
  end
end
