require "test_helper"

class PostsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
    @post = posts(:ruby)
  end

  test "delete own post and no longer see it" do
    log_in_as(@user)
    get post_path(posts(:test))
    assert_select 'a', { text: 'delete', count: 0 }
    get user_path(@user)
    assert_select "a[href=?]", post_path(@post)
    get post_path(@post)
    assert_select 'a', text: 'delete'
    assert_difference 'Post.count', -1 do
      delete post_path(posts(:ruby))
    end
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_select "a[href=?]", post_path(@post), count: 0
    assert_not flash.empty?
  end
end
