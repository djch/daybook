require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "should save untitled documents" do
    article = Article.new
    assert article.save
    assert article.title = 'Untitled'
  end
end
