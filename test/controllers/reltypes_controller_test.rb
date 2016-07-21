require 'test_helper'

class ReltypesControllerTest < ActionController::TestCase
  setup do
    @reltype = reltypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reltypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reltype" do
    assert_difference('Reltype.count') do
      post :create, reltype: { color: @reltype.color, name: @reltype.name, short: @reltype.short }
    end

    assert_redirected_to reltype_path(assigns(:reltype))
  end

  test "should show reltype" do
    get :show, id: @reltype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reltype
    assert_response :success
  end

  test "should update reltype" do
    patch :update, id: @reltype, reltype: { color: @reltype.color, name: @reltype.name, short: @reltype.short }
    assert_redirected_to reltype_path(assigns(:reltype))
  end

  test "should destroy reltype" do
    assert_difference('Reltype.count', -1) do
      delete :destroy, id: @reltype
    end

    assert_redirected_to reltypes_path
  end
end
