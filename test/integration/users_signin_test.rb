require 'test_helper'

class UsersSignInTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:arya)
  end

  test "can't sign in with invalid details" do
    get sign_in_path
    assert_select 'form[action="/sign_in"]'
    post sign_in_path, params: { session: { email: "", password: "" } }
    assert_not flash.empty?
    assert_select 'form[action="/sign_in"]'
    # Make sure the flash doesn't persist after navigating away
    get root_path
    assert flash.empty?
  end

  test "can sign in with valid details and then sign out" do
    # Sign in
    get sign_in_path
    assert_select 'form[action="/sign_in"]'
    post sign_in_path, params: { session: { email: @user.email, password: 'ValarMorghulis' } }
    assert is_logged_in?
    follow_redirect!
    assert_select "a[href=?]", sign_in_path, count: 0
    assert_select "a[href=?]", sign_out_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "h1", @user.name
    # Sign out
    delete sign_out_path
    assert_not is_logged_in?
    follow_redirect!
    assert_select "a[href=?]", sign_in_path
    assert_select "a[href=?]", sign_out_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end