require "test_helper"
include Warden::Test::Helpers

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'creating a notification' do
    login_as User.find(2)
    post reactions_path(post_id: Post.first.slug)
    assert Notification.where(sender: User.find(2), post_id: 1).first.present?
  end

  test 'mark as seen' do
    login_as User.find(2)
    post '/update_notifications'
    assert Notification.last.seen == true, 'it should update the notification'
  end
end
