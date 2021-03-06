require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Day Book"
  end

  test "can get the welcome page" do
    get root_path
    assert_response :success
    assert_select "title", "Welcome – #{@base_title}"
  end

  test "can get the about page" do
    get about_path
    assert_response :success
    assert_select "title", "About – #{@base_title}"
  end
end
