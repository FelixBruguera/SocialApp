require "test_helper"

class ChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'uniqueness validation' do
    chat = Chat.new(user_id: 1, friend_id: 3)
    assert_not chat.save, 'should return a validation error'
  end
end
