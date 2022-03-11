require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home should render login page when not logged in" do
    get root_path
    assert_response :success
    assert_template 'sessions/new'
    assert_select 'title', full_title("Log in")
  end

  test "home should feed when logged in" do
    log_in_as(users(:bob))
    get root_path
    assert_response :success
    assert_template 'posts/feed'
    assert_select 'title', full_title
  end
end
