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

  test "can sign up with valid details" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Llewyn Davis", email: "llewyn@nyc.com", password: "Gaslight59" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    follow_redirect!
    assert_select 'div.flash-content-notice'
    assert is_logged_in?
  end
end
