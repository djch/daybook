require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "request password reset" do
    @user = users(:brienne)
    post sign_in_path, params: { session: { email: @user.email, password: "IncorrectPw" } }
    assert_select "a[href=?]", forgot_password_path
    get forgot_password_path
    assert_select 'form[action="/forgot_password"]'
    # Invalid email
    post forgot_password_path, params: { password_reset: { email: 'brieen@evenfallhall.org' } }
    assert_not flash.empty?
    assert_select 'form[action="/forgot_password"]'
    # Valid email
    post forgot_password_path, params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "reset password with link" do
    user = users(:daenerys)
    reset_token = 'iGqEHcHgh4IQbVJpvB4Taw'
    # Right token, wrong email
    get edit_password_reset_path(reset_token, email: 'queen@westeros.gov')
    assert_redirected_to root_url
    # Right email, wrong token
    get edit_password_reset_path('AllYourBaseRBeling2Us!', email: user.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(reset_token, email: user.email)
    assert_select 'input[name=email][type=hidden][value=?]', user.email
    # Invalid new password
    patch password_reset_path(reset_token), params: { email: user.email, user: { password: 'Mhysa' } }
    assert_select 'div#error_explanation'
    # Valid new password
    patch password_reset_path(reset_token), params: { email: user.email, user: { password: 'Dracarys' } }
    assert is_logged_in?
    assert_nil user.reload.reset_digest
    assert_not flash.empty?
    assert_redirected_to user
  end

  test "expired password reset link" do
    user = users(:samwell)
    reset_token = 'VEwm1cSlHtQasKXp5S2Wog'
    patch password_reset_path(reset_token), params: { email: user.email, user: { password: 'Steelsong' } }
    assert_response :redirect
    follow_redirect!
    assert_match /expired/i, response.body
  end
end
