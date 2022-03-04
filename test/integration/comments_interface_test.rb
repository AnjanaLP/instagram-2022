require "test_helper"

class CommentsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
    @post = posts(:ruby)
  end

  test "can create a comment on an existing post" do
    log_in_as(@user)
    get post_path(@post)
    assert_select "form"
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_no_match "Test comment", response.body
    assert_difference '@post.comments.count', 1 do
      post post_comments_path(@post), params: { comment: { content: "Test comment" } }
    end
    assert_redirected_to post_path(@post)
    follow_redirect!
    assert_select "a[href=?]", user_path(@user)
    assert_match "Test comment", response.body
  end
end
