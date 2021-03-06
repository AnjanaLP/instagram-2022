require "test_helper"

class RelationshipsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:bob)
    @other_user = users(:user_5)
    log_in_as(@user)
  end

  test "followers page" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "can follow another user" do
    assert_difference '@user.following.count', 1 do
      post relationships_path, params: { followed_id: @other_user.id }
    end
  end

  test "can unfollow a user they are following" do
    @user.follow(@other_user)
    relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
    assert_difference '@user.following.count', -1 do
      delete relationship_path(relationship)
    end
  end
end
