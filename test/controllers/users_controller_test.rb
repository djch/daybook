require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  test "should get the sign-up screen" do
    get signup_path
    assert_response :success
  end
end
