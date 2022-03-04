require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "should redirect create when not logged in" do
    assert_no_difference 'Like.count' do
      post post_likes_path(posts(:ruby)) 
    end
    assert_redirected_to login_url
    assert_not flash.empty?
  end
end
