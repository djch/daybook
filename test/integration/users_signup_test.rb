require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "cannot sign up with invalid details" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "", email: "nope@dotorg", password: "qwerty" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "can sign up with valid details and receive activation email" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Llewyn Davis", email: "llewyn@nyc.com", password: "Gaslight59" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = User.find_by(email: 'llewyn@nyc.com')
    assert_not user.activated?
    follow_redirect!
    assert_select 'div.flash-content-notice'
    assert_not is_logged_in?
  end

  test "can activate account with valid link" do
    user = users(:daenerys)
    # Try to log in before activation.
    log_in_as(user, password: 'SunAndStars')
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path('8N8yoLNdCEAhdu6vw-oauw', email: 'queen@westeros.gov')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path('8N8yoLNdCEAhdu6vw-oauw', email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert is_logged_in?
  end
end
