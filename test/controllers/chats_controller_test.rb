require "test_helper"
include Warden::Test::Helpers

class ChatsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'render chats index' do
    login_as User.first
    get chats_path
    assert_select '.chat-box', minimum: 1
  end

  test 'render chat' do
    login_as User.first
    get chat_path(Chat.first.slug)
    assert_select ".message-#{User.first.slug} > p", {minimum: 1, text: 'Test'}
  end
end
