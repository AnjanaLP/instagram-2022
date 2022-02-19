require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "site layout" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path

    get signup_path
    assert_template 'users/new'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", login_path

    get login_path
    assert_template 'sessions/new'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", signup_path
  end
end
