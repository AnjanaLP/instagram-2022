require "test_helper"

class LikeTest < ActiveSupport::TestCase
  def setup
    @post = posts(:ruby)
    @like = @post.likes.build(user_id: users(:bob).id)
  end

  test "valid like" do
    assert @like.valid?
  end

  test "user_id should be a valid user" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "post_id should be a valid post" do
    @like.post_id = nil
    assert_not @like.valid?
  end

  test "user should not like a post more than once" do
    duplicate_like = @like.dup
    @like.save
    assert_not duplicate_like.valid?
  end
end
