require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:brienne)
    @admin = users(:cersei)
  end

  test "cannot update user with invalid changes" do
    log_in_as(@user, password: "OathKeeper")
    get edit_user_path(@user)
    assert_select 'form[class="edit_user"]'
    patch user_path(@user), params: { user: { name: "", email: "brienne@starks", password: "X" } }
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'form[class="edit_user"]'
  end

  test "can update and delete own user after signing in and being forwarded" do
    get edit_user_path(@user)
    log_in_as(@user, password: "OathKeeper")
    # User should be forwarded to original destination once logged in
    assert_redirected_to edit_user_url(@user)
    follow_redirect!
    assert_not session[:forwarding_url]
    assert_select 'form[class="edit_user"]'
    # User needs to update their name only
    name = "Ser Brienne"
    patch user_path(@user), params: { user: { name: name, email: @user.email, password: "" } }
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.name
    assert_select "h1", @user.name
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "can edit and delete a user account as an admin" do
    log_in_as(@admin, password: "LoveIsPoison")
    get user_path(@user)
    assert_select 'a[href=?]', edit_user_path(@user)
    assert_select 'a', text: "Delete account"
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end
end
