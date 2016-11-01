require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
    @comment = comments(:one)
  end

  test "should add comment on article" do
    assert_difference("Comment.count") do
      post article_comments_url(@article),
                                xhr: true,
                                params: { comment: { commenter: "Jason M.",
                                                     body: "Heynong man" } }
    end
    assert_equal "text/javascript", @response.content_type
    assert_equal 200, @response.status
  end
  test "should remove comment from article" do
    get article_path(@article)
    assert_difference("Comment.count", -1) do
      delete article_comment_url(@comment), xhr: true
    end
    assert_response :success
  end
end
