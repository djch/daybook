require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "should return the full title" do
    assert_equal full_title, "Day Book"
    assert_equal full_title("About"), "About – Day Book"
  end
end