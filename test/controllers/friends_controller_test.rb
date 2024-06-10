require "test_helper"
include Warden::Test::Helpers

class FriendsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'accepting a request' do
    login_as User.find(2)
    uuid = FriendRequest.last.slug
    post friends_path(id: uuid)
    assert FriendRequest.where(slug: uuid).first.nil?, 'it should delete the request'
    assert_not Friend.where(user_id: 1).and(Friend.where(friend_id: 2)).empty?, 'it should create the friendship'
    assert_not Friend.where(user_id: 2).and(Friend.where(friend_id: 1)).empty?, 'it should create the reverse friendship'
    assert_not Chat.where(user_id: 1).and(Chat.where(friend_id: 2)).empty?, 'it should create a chat'
  end

  test 'unfriend' do
    login_as User.first
    friendship = Friend.first
    delete friend_path(friendship.slug)
    assert Friend.where(user_id: 1).and(Friend.where(friend_id: 3)).first.nil?, 'it should destroy the friendship'
    assert Friend.where(user_id: 3).and(Friend.where(friend_id: 1)).first.nil?, 'it should destroy the reverse friendship'

  end
end
