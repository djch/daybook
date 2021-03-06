require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get articles index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
    assert_select 'div.article-editor'
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { title: "Flows",
                                               text: "The dimension of time." } }
    end
    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get article editor" do
    get edit_article_url(@article)
    assert_response :success
    assert_select 'div.article-editor'
  end

  test "should update article" do
    patch article_url(@article), params: { article: { title: "",
                                                       text: "The owls are not what they seem." } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal "Untitled", @article.title
    assert_equal "The owls are not what they seem.", @article.text
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
    assert_equal "✔︎ The article was deleted", flash[:notice]
  end
end
