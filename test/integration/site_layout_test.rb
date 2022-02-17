require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "site layout" do
    get root_path
    assert_template 'users/show'
  end
end
