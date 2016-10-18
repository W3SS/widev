require 'test_helper'

class Time::FestivitaControllerTest < ActionController::TestCase
  setup do
    @time_festivitum = time_festivita(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_festivita)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_festivitum" do
    assert_difference('Time::Festivitum.count') do
      post :create, time_festivitum: { chargeable: @time_festivitum.chargeable, festdate: @time_festivitum.festdate, forecast_val: @time_festivitum.forecast_val, name: @time_festivitum.name }
    end

    assert_redirected_to time_festivitum_path(assigns(:time_festivitum))
  end

  test "should show time_festivitum" do
    get :show, id: @time_festivitum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_festivitum
    assert_response :success
  end

  test "should update time_festivitum" do
    patch :update, id: @time_festivitum, time_festivitum: { chargeable: @time_festivitum.chargeable, festdate: @time_festivitum.festdate, forecast_val: @time_festivitum.forecast_val, name: @time_festivitum.name }
    assert_redirected_to time_festivitum_path(assigns(:time_festivitum))
  end

  test "should destroy time_festivitum" do
    assert_difference('Time::Festivitum.count', -1) do
      delete :destroy, id: @time_festivitum
    end

    assert_redirected_to time_festivita_path
  end
end
