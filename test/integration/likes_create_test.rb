require "test_helper"

class LikesCreateTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:ruby)
  end

  test "user can like a post once" do
    log_in_as(users(:bob))
    get post_path(@post)
    assert_match "0 likes", response.body
    assert_difference '@post.likes.count', 1 do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_match "1 like", response.body
    assert_no_difference '@post.likes.count' do
      post post_likes_path(@post)
    end
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    log_in_as(users(:alice))
    get post_path(@post)
    assert_match "1 like", response.body
    assert_difference '@post.likes.count', 1 do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_match "2 likes", response.body
  end
end
