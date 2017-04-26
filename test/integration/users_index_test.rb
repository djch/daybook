require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:arya)
  end

  test "can view the full paginated list of users" do
    log_in_as(@user, password:"ValarMorghulis")
    get users_path
    assert_select 'h1', "Here's everyone on Day Book"
    assert_select 'h2', 15
    assert_select 'a[href="/users?page=2"]'
  end
end
