require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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
      post signup_path, params: { user: { name: "Llewyn Davis", email: "Llewyn@nyc.com", password: "Gaslight" } }
    end
    follow_redirect!
    assert_select 'div.flash-content-notice'
  end
end
