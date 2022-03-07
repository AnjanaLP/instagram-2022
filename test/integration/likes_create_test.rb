require "test_helper"

class LikesCreateTest < ActionDispatch::IntegrationTest
  def setup
    @bob = users(:bob)
    @alice = users(:alice)
    @post = posts(:ruby)
  end

  test "user can like a post once and see it" do
    log_in_as(users(:bob))
    get post_path(@post)
    assert_select 'a[href=?]', likes_post_path(@post), text: "0 likes"
    assert_difference '@post.likes.count', 1 do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_select 'a', text: "1 like"
    assert_no_difference '@post.likes.count' do
      post post_likes_path(@post)
    end
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    log_in_as(@alice)
    get post_path(@post)
    assert_select 'a', text: "1 like"
    assert_difference '@post.likes.count', 1 do
      post post_likes_path(@post)
    end
    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_select 'a', text: "2 likes"
    get likes_post_path(@post)
    assert_select "a[href=?]", user_path(@bob), text: @bob.username
    assert_select "a[href=?]", user_path(@alice), text: @alice.username
  end
end
