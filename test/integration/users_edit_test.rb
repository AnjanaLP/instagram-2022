require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "bob@invalid",
                                              username: "",
                                              password: "short" } }
    assert_template 'users/edit'
    assert_select 'div.error-messages'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_not_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    follow_redirect!
    assert_template 'users/edit'
    name  = "Updated Name"
    email = "updated@example.com"
    username = "updated-user"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              username: username,
                                              password: "" } }
    assert_not flash.empty?
    @user.reload
    assert_redirected_to @user
    assert_nil session[:forwarding_url]

    assert_equal name,  @user.name
    assert_equal email, @user.email
    assert_equal username, @user.username
  end

  test "successful deletion of account" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
    assert_not is_logged_in?
  end
end
