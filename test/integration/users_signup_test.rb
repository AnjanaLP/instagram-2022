require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "unsuccessful sign up" do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "@invalid",
                                         username: "",
                                         password: "short" } }
    end
    assert_template 'users/new'
    assert_select('div.error-messages')
  end

  test "successful sign up" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Test User",
                                         email: "test-user@example.com",
                                         username: "test-user",
                                         password: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert_select 'title', full_title('Test User (@test-user)')
    assert_match 'test-user', response.body
  end
end
