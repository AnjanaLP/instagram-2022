require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:ruby)
    @other_user = users(:bob)
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

  test "should redirect edit when not logged in" do
    get edit_post_path(@post)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as the wrong user" do
    log_in_as(@other_user)
    get edit_post_path(@post)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    patch post_path(@post), params: { post: { caption: "Updated caption" } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as the wrong user" do
    log_in_as(@other_user)
    patch post_path(@post), params: { post: { caption: "Updated caption" } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as the wrong user" do
    log_in_as(@other_user)
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert flash.empty?
    assert_redirected_to root_url
  end
end
