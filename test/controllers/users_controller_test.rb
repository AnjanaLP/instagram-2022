require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select 'title', full_title("Sign up")
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
    assert_select 'title', full_title("#{@user.name} (@#{@user.username})")
  end

  test "should get edit when logged in" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
    assert_select 'title', full_title("Edit profile")
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
