require 'test_helper'

class QueryChecksControllerTest < ActionController::TestCase
  setup do
    @query_check = query_checks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:query_checks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create query_check" do
    assert_difference('QueryCheck.count') do
      post :create, query_check: { is_paused: @query_check.is_paused, is_started: @query_check.is_started, last_exec_dt: @query_check.last_exec_dt, num_exec: @query_check.num_exec, rpt_interval: @query_check.rpt_interval, statement: @query_check.statement, title: @query_check.title }
    end

    assert_redirected_to query_check_path(assigns(:query_check))
  end

  test "should show query_check" do
    get :show, id: @query_check
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @query_check
    assert_response :success
  end

  test "should update query_check" do
    patch :update, id: @query_check, query_check: { is_paused: @query_check.is_paused, is_started: @query_check.is_started, last_exec_dt: @query_check.last_exec_dt, num_exec: @query_check.num_exec, rpt_interval: @query_check.rpt_interval, statement: @query_check.statement, title: @query_check.title }
    assert_redirected_to query_check_path(assigns(:query_check))
  end

  test "should destroy query_check" do
    assert_difference('QueryCheck.count', -1) do
      delete :destroy, id: @query_check
    end

    assert_redirected_to query_checks_path
  end
end
