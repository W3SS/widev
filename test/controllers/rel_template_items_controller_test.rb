require 'test_helper'

class RelTemplateItemsControllerTest < ActionController::TestCase
  setup do
    @rel_template_item = rel_template_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rel_template_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rel_template_item" do
    assert_difference('RelTemplateItem.count') do
      post :create, rel_template_item: { description: @rel_template_item.description, name: @rel_template_item.name, note: @rel_template_item.note }
    end

    assert_redirected_to rel_template_item_path(assigns(:rel_template_item))
  end

  test "should show rel_template_item" do
    get :show, id: @rel_template_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rel_template_item
    assert_response :success
  end

  test "should update rel_template_item" do
    patch :update, id: @rel_template_item, rel_template_item: { description: @rel_template_item.description, name: @rel_template_item.name, note: @rel_template_item.note }
    assert_redirected_to rel_template_item_path(assigns(:rel_template_item))
  end

  test "should destroy rel_template_item" do
    assert_difference('RelTemplateItem.count', -1) do
      delete :destroy, id: @rel_template_item
    end

    assert_redirected_to rel_template_items_path
  end
end
