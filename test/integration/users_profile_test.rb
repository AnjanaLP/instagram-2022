require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alice)
  end

  test "display profile page" do
    get user_path(@user)
    assert_template 'users/show'
    assert_match @user.username, response.body
    assert_select 'p', text: @user.name
    assert_select 'h1>svg.bi-person-circle'
    assert_match @user.posts.count.to_s, response.body
    @user.posts.each do |post|
      assert_select 'a[href=?]', post_path(post)
    end
  end
end
