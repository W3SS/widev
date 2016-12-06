require 'test_helper'

class Siebel::ParametersControllerTest < ActionController::TestCase
  setup do
    @siebel_parameter = siebel_parameters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:siebel_parameters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create siebel_parameter" do
    assert_difference('Siebel::Parameter.count') do
      post :create, siebel_parameter: { enterprise: @siebel_parameter.enterprise, pa_alias: @siebel_parameter.pa_alias, pa_setlevel: @siebel_parameter.pa_setlevel, pa_value: @siebel_parameter.pa_value, ptype: @siebel_parameter.ptype, server: @siebel_parameter.server, version: @siebel_parameter.version }
    end

    assert_redirected_to siebel_parameter_path(assigns(:siebel_parameter))
  end

  test "should show siebel_parameter" do
    get :show, id: @siebel_parameter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @siebel_parameter
    assert_response :success
  end

  test "should update siebel_parameter" do
    patch :update, id: @siebel_parameter, siebel_parameter: { enterprise: @siebel_parameter.enterprise, pa_alias: @siebel_parameter.pa_alias, pa_setlevel: @siebel_parameter.pa_setlevel, pa_value: @siebel_parameter.pa_value, ptype: @siebel_parameter.ptype, server: @siebel_parameter.server, version: @siebel_parameter.version }
    assert_redirected_to siebel_parameter_path(assigns(:siebel_parameter))
  end

  test "should destroy siebel_parameter" do
    assert_difference('Siebel::Parameter.count', -1) do
      delete :destroy, id: @siebel_parameter
    end

    assert_redirected_to siebel_parameters_path
  end
end
