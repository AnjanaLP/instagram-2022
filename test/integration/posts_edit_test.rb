require "test_helper"

class PostsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
    @post = posts(:ruby)
  end

  test "can edit a post and see it" do
    new_caption  = "Updated Caption"
    log_in_as(@user)
    get post_path(@post)
    assert_no_match new_caption, response.body
    assert_no_match 'bowling.png', response.body
    get edit_post_path(@post)
    assert_template 'posts/edit'
    image = fixture_file_upload('bowling.png', 'image/png')
    patch post_path(@post), params: { post: { caption: new_caption, image: image } }
    assert_not flash.empty?
    assert_redirected_to @user
    get post_path(@post)
    assert_match new_caption, response.body
    assert_match 'bowling.png', response.body
  end
end
