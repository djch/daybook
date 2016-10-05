require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "can get articles" do
    get articles_url
    assert_response :success
  end
end
