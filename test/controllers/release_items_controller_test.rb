require 'test_helper'

class ReleaseItemsControllerTest < ActionController::TestCase
  setup do
    @release_item = release_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:release_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create release_item" do
    assert_difference('ReleaseItem.count') do
      post :create, release_item: { name: @release_item.name, remove: @release_item.remove, scratchable: @release_item.scratchable, type: @release_item.type }
    end

    assert_redirected_to release_item_path(assigns(:release_item))
  end

  test "should show release_item" do
    get :show, id: @release_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @release_item
    assert_response :success
  end

  test "should update release_item" do
    patch :update, id: @release_item, release_item: { name: @release_item.name, remove: @release_item.remove, scratchable: @release_item.scratchable, type: @release_item.type }
    assert_redirected_to release_item_path(assigns(:release_item))
  end

  test "should destroy release_item" do
    assert_difference('ReleaseItem.count', -1) do
      delete :destroy, id: @release_item
    end

    assert_redirected_to release_items_path
  end
end
