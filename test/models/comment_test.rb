require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:alice)
    @post = posts(:ruby)
    @comment = @post.comments.build(content: "Test comment", user_id: @user.id)
  end

  test "valid comment" do
    assert @comment.valid?
  end

  test "user id should be a valid user" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "content should not be blank" do
    @comment.content = "" * 10
    assert_not @comment.valid?
  end

  test "content should not be longer than 2200 characters" do
    @comment.content = "a" * 2201
    assert_not @comment.valid?
  end
end
