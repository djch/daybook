require 'test_helper'

class WelcomeFlowTest < ActionDispatch::IntegrationTest
  test "can be welcomed to Day Book" do
    get root_url
    # Do we know what it's called?
    assert_select "h1", "Day Book"
    assert_select "title", full_title("Welcome")
    # Can we naviagte to resources?
    assert_select "a[href=?]", articles_path
    assert_select "a[href=?]", about_path
    get about_path
    assert_select "h1", "About Day Book"
    assert_select "a[href=?]", root_path
    # Can we go back home?
    get root_path
  end
end
