require "test_helper"
include Warden::Test::Helpers

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'sending a request' do
    login_as User.first
    post friend_requests_path(receiver:'Carlos-Martinez-1234')
    assert FriendRequest.last.receiver == '2', 'correct receiver'
    assert FriendRequest.last.sender == '1', 'correct sender'
  end

  test 'ignoring a request' do
    friend_request = FriendRequest.first
    put friend_request_path(friend_request.slug, friend_request: {ignored: true})
    assert FriendRequest.first.ignored == true, 'it should update the request'
  end
end
