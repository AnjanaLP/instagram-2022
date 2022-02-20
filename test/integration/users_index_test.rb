require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:bob)
  end

  test "list all users with pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.apple_pagination', count: 2
    User.paginate(page: 1, per_page: 15).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.username
    end
  end
end
