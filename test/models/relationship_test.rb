require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:bob).id,
                                     followed_id: users(:alice).id)
  end

  test "valid relationship" do
    assert @relationship.valid?
  end

  test "follower_id should be a valid user" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "followed_id should be a valid user" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
