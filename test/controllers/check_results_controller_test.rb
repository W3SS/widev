require 'test_helper'

class CheckResultsControllerTest < ActionController::TestCase
  setup do
    @check_result = check_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:check_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create check_result" do
    assert_difference('CheckResult.count') do
      post :create, check_result: { query_check_id: @check_result.query_check_id, value: @check_result.value }
    end

    assert_redirected_to check_result_path(assigns(:check_result))
  end

  test "should show check_result" do
    get :show, id: @check_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @check_result
    assert_response :success
  end

  test "should update check_result" do
    patch :update, id: @check_result, check_result: { query_check_id: @check_result.query_check_id, value: @check_result.value }
    assert_redirected_to check_result_path(assigns(:check_result))
  end

  test "should destroy check_result" do
    assert_difference('CheckResult.count', -1) do
      delete :destroy, id: @check_result
    end

    assert_redirected_to check_results_path
  end
end
