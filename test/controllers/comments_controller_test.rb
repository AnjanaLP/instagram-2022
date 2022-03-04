require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post post_comments_path(posts(:ruby)), params: { comment: { content: "Test comment" } }
    end
    assert_redirected_to login_url
    assert_not flash.empty?
  end
end
