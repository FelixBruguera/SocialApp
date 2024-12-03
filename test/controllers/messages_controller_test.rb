require "test_helper"
include Warden::Test::Helpers

class MessagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'sending a message' do
    login_as User.first
    post messages_path(message: {body: 'Testing messages', chat_id: Chat.first.slug, user_id: User.first.slug})
    assert Message.last.body == 'Testing messages', 'It should create the message'
    assert Message.last.chat == Chat.first, 'The message should link to the chat'
    assert Message.last.user == User.first, 'The message should link to the sender'
  end

  test 'marking messages as read' do
    login_as User.first
    post "/messages_read?chat_id=#{Chat.first.slug}"
    assert Message.last.seen == true, 'It should update the message to seen'
  end
end
