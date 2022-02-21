require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:alice)
    @post = @user.posts.build(caption: "Test post")
  end

  test "valid post" do
    assert @post.valid?
  end

  test "user id should be a valid user" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "caption should not be longer than 2200 characters" do
    @post.caption = "a" * 2201
    assert_not @post.valid?
  end

  test "should be in reverse chronological order" do
    assert_equal posts(:latest), Post.first
  end
end
