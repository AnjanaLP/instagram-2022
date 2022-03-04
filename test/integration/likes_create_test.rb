require "test_helper"

class LikesCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
    @post = posts(:ruby)
  end

  test "can like a post" do
    log_in_as(@user)
    get post_path(@post)
    assert_match "0 likes", response.body
    assert_difference '@post.likes.count', 1 do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_match "1 like", response.body
  end
end
