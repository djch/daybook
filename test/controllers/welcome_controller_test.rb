require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "can get the welcome page" do
    get "/"
    assert_response :success
  end

  test "can get the about page" do
    get welcome_about_url
    assert_response :success
  end
end
