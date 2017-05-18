require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:brienne)
    @other_user = users(:samwell)
    @inactive_user = users(:daenerys)
  end

  test "should get the sign-up screen" do
    get signup_path
    assert_response :success
  end

  test "should redirect user index when not signed in" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to sign_in_url
  end

  test "should redirect user edit when not signed in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to sign_in_url
  end

  test "should redirect user update when not signed in" do
    patch user_path(@user), params: { user: { name: "Lady Brienne", email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to sign_in_url
  end

  test "should redirect attempts to edit another user" do
    log_in_as(@other_user, password: "DragonGlass")
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect attempts to update another user" do
    log_in_as(@other_user, password: "DragonGlass")
    patch user_path(@user), params: { user: { name: "Lady Brienne", email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should prevent the admin attribute from being edited via the web" do
    log_in_as(@other_user, password: "DragonGlass")
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { admin: "true" } }
    assert_not @other_user.reload.admin?
  end

  test "should redirect user deletion when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to sign_in_url
  end

  test "should redirect user deletion when not the owner of it OR an admin" do
    log_in_as(@other_user, password: "DragonGlass")
    get user_path(@user)
    assert_select 'a[href=?]', user_path(@user), count: 0
    assert_select 'a', text: "Delete account", count: 0
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should not show inactive users to anyone" do
    log_in_as(@other_user, password: "DragonGlass")
    get users_path
    assert_select 'a[href=?]', user_path(@other_user)
    assert_select 'a[href=?]', user_path(@inactive_user), count: 0
    get user_path(@inactive_user)
  end
end
