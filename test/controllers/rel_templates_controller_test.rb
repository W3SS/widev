require 'test_helper'

class RelTemplatesControllerTest < ActionController::TestCase
  setup do
    @rel_template = rel_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rel_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rel_template" do
    assert_difference('RelTemplate.count') do
      post :create, rel_template: { name: @rel_template.name }
    end

    assert_redirected_to rel_template_path(assigns(:rel_template))
  end

  test "should show rel_template" do
    get :show, id: @rel_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rel_template
    assert_response :success
  end

  test "should update rel_template" do
    patch :update, id: @rel_template, rel_template: { name: @rel_template.name }
    assert_redirected_to rel_template_path(assigns(:rel_template))
  end

  test "should destroy rel_template" do
    assert_difference('RelTemplate.count', -1) do
      delete :destroy, id: @rel_template
    end

    assert_redirected_to rel_templates_path
  end
end
