require 'test_helper'

class ItemPerInstallationsControllerTest < ActionController::TestCase
  setup do
    @item_per_installation = item_per_installations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_per_installations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_per_installation" do
    assert_difference('ItemPerInstallation.count') do
      post :create, item_per_installation: { end_time: @item_per_installation.end_time, installation: @item_per_installation.installation, is_done: @item_per_installation.is_done, is_error: @item_per_installation.is_error, is_started: @item_per_installation.is_started, note: @item_per_installation.note, rel_template_item: @item_per_installation.rel_template_item, start_time: @item_per_installation.start_time }
    end

    assert_redirected_to item_per_installation_path(assigns(:item_per_installation))
  end

  test "should show item_per_installation" do
    get :show, id: @item_per_installation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_per_installation
    assert_response :success
  end

  test "should update item_per_installation" do
    patch :update, id: @item_per_installation, item_per_installation: { end_time: @item_per_installation.end_time, installation: @item_per_installation.installation, is_done: @item_per_installation.is_done, is_error: @item_per_installation.is_error, is_started: @item_per_installation.is_started, note: @item_per_installation.note, rel_template_item: @item_per_installation.rel_template_item, start_time: @item_per_installation.start_time }
    assert_redirected_to item_per_installation_path(assigns(:item_per_installation))
  end

  test "should destroy item_per_installation" do
    assert_difference('ItemPerInstallation.count', -1) do
      delete :destroy, id: @item_per_installation
    end

    assert_redirected_to item_per_installations_path
  end
end
