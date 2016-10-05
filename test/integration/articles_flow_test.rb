require "test_helper"

class ArticlesFlowTest < ActionDispatch::IntegrationTest
  test "can be welcomed to Day Book" do
    get "/"
    assert_select "h1", "Day Book"
  end
  test "can create an article" do
    get new_article_url
    assert_response :success

    post articles_url,
      params: { article: { title: "Can Create", text: "a new article. ✅" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1", "Can Create"
  end
end
