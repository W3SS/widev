require 'test_helper'

class SkillsToProfilesControllerTest < ActionController::TestCase
  setup do
    @skills_to_profile = skills_to_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skills_to_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skills_to_profile" do
    assert_difference('SkillsToProfile.count') do
      post :create, skills_to_profile: { add1: @skills_to_profile.add1, add2: @skills_to_profile.add2, note: @skills_to_profile.note, proficency: @skills_to_profile.proficency }
    end

    assert_redirected_to skills_to_profile_path(assigns(:skills_to_profile))
  end

  test "should show skills_to_profile" do
    get :show, id: @skills_to_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @skills_to_profile
    assert_response :success
  end

  test "should update skills_to_profile" do
    patch :update, id: @skills_to_profile, skills_to_profile: { add1: @skills_to_profile.add1, add2: @skills_to_profile.add2, note: @skills_to_profile.note, proficency: @skills_to_profile.proficency }
    assert_redirected_to skills_to_profile_path(assigns(:skills_to_profile))
  end

  test "should destroy skills_to_profile" do
    assert_difference('SkillsToProfile.count', -1) do
      delete :destroy, id: @skills_to_profile
    end

    assert_redirected_to skills_to_profiles_path
  end
end
