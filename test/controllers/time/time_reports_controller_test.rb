require 'test_helper'

class Time::TimeReportsControllerTest < ActionController::TestCase
  setup do
    @time_time_report = time_time_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_time_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_time_report" do
    assert_difference('Time::TimeReport.count') do
      post :create, time_time_report: { hours: @time_time_report.hours, note: @time_time_report.note, repdate: @time_time_report.repdate }
    end

    assert_redirected_to time_time_report_path(assigns(:time_time_report))
  end

  test "should show time_time_report" do
    get :show, id: @time_time_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_time_report
    assert_response :success
  end

  test "should update time_time_report" do
    patch :update, id: @time_time_report, time_time_report: { hours: @time_time_report.hours, note: @time_time_report.note, repdate: @time_time_report.repdate }
    assert_redirected_to time_time_report_path(assigns(:time_time_report))
  end

  test "should destroy time_time_report" do
    assert_difference('Time::TimeReport.count', -1) do
      delete :destroy, id: @time_time_report
    end

    assert_redirected_to time_time_reports_path
  end
end
