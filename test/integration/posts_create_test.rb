require "test_helper"

class PostsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
  end

  test "create own post and see it" do
    log_in_as(@user)
    get user_path(@user)
    assert_match "0 posts", response.body
    get new_post_path
    assert_select 'input[type=file]'
    caption = "Test Post"
    image = fixture_file_upload('bowling.png', 'image/png')
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { caption: caption, image: image } }
    end
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_match "1 post", response.body
    assert_match 'bowling.png', response.body
    new_post = @user.posts.first
    assert new_post.image.attached?
    assert_select 'a[href=?]', post_path(new_post)
    get post_path(new_post)
    assert_match 'bowling.png', response.body
    assert_match caption, response.body
  end
end
