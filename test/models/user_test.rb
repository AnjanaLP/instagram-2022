require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User",
                     email: "test@example.com",
                     username: "test-user",
                     password: "password123")
  end

  test "correct credentials should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "username should be present" do
    @user.username = "   "
    assert_not @user.valid?
  end

  test "name should not be longer than 50 characters" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be longer than 255 characters" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "username should not be longer than 50 characters" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "correct email format should be valid" do
    valid_addresses = %w[user@example.com USER@test.COM A_US-ER@test.user.org
                         test.user@test.jp test+user@test.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "incorrect email format should not be valid" do
    invalid_addresses = %w[user@example,com user_at_test.user user.test@example.
                           user@test_example.com user@test+example.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = User.new(name: "duplicate_user",
                              email: @user.email,
                              username: "duplicate-user")
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lower-case" do
    mixed_case_email = "tEsT@ExAmPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "username should be unique" do
    duplicate_user = User.new(name: "duplicate_user",
                              email: "duplicate@example.com",
                              username: @user.username)
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should not be blank spaces" do
    @user.password = "      "
    assert_not @user.valid?
  end

  test "password should not be less than 6 characters" do
    @user.password = "a" * 5
    assert_not @user.valid?
  end
end
