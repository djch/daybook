require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "should not save comment without commenter" do
    comment = Comment.new
    assert_not comment.save, "Added the comment without a commenter"
  end
end
