require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:ruby)
  end

  test "should get new" do
    log_in_as(users(:alice))
    get new_post_path
    assert_response :success
    assert_select 'title', full_title("Create new post")
  end

  test "should get show" do
    get post_path(@post)
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { caption: "Test post" } }
    end
    assert_redirected_to login_url
    assert_not flash.empty?
  end
end
