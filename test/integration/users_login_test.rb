require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
  end

  test "unsuccessful login with correct email but incorrect password" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: "wrong password" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "unsuccessful login with correct password but incorrect email" do
    get login_path
    post login_path, params: { session: { email: "invalid@example.com", password: 'password' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "successful login with correct email and correct password" do
    get login_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", logout_path, count: 0
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", logout_path
    assert is_logged_in?
  end
end
