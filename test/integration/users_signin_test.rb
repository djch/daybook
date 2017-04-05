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
    get sign_in_path
    assert_select 'form[action="/sign_in"]'
    # Sign in
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
    # Simulate a user signing out in a second window.
    delete sign_out_path
    follow_redirect!
    assert_select "a[href=?]", sign_in_path
    assert_select "a[href=?]", sign_out_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "can be permanently remembered as a signed in user" do
    log_in_as(@user, password: 'ValarMorghulis', remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "can be forgetten as a signed in user when the browser is closed" do
    # Log in to set the cookie.
    log_in_as(@user, password: 'ValarMorghulis', remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, password: 'ValarMorghulis', remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
