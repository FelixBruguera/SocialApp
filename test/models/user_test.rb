require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'good parameters' do
    user = User.new(first_name: 'Felix', last_name: 'Bruguera', email: 'f@b.com', password: '123456',
                   username: 'Felix-Bruguera-1234', uuid: SecureRandom.uuid)
    assert user.valid?, 'user is valid'
  end

  test 'duplicated email' do
    user = User.new(first_name: 'Felix', last_name: 'Bruguera', email: 'pedro@perez.com', password: '123456',
                   username: 'Felix-Bruguera-1234', uuid: SecureRandom.uuid)
    assert_not user.valid?, 'user is not valid'
  end

  test 'empty email' do
    user = User.new(first_name: 'Felix', last_name: 'Bruguera', email: '', password: '123456',
                   username: 'Felix-Bruguera-1234', uuid: SecureRandom.uuid)
    assert_not user.valid?, 'user is not valid'
  end

  test 'posts association' do
    posts = User.first.posts
    assert_not posts.empty?, 'association is valid'
    assert posts.first.user == User.first, 'association is valid'
  end

  test 'notifications association' do
    notification = User.find(2).notifications
    assert_not notification.empty?, 'association is valid'
    assert notification.first.receiver == User.find(2), 'association is valid'
  end

  test 'friends association' do
    friends = User.first.friends
    assert_not friends.empty?, 'association is valid'
    assert friends.first.user_id == User.first.id, 'association is valid'
  end

  test 'chats association' do
    chats = User.first.chats
    assert_not chats.empty?, 'association is valid'
    assert chats.first.user_id == User.first.id, 'association is valid'
  end

  test 'messages association' do
    messages = User.first.messages
    assert_not messages.empty?, 'association is valid'
    assert messages.first.user_id == User.first.id, 'association is valid'
  end

  test 'comments association' do
    comments = User.first.comments
    assert_not comments.empty?, 'association is valid'
    assert comments.first.user_id == User.first.id, 'association is valid'
  end

  test 'birthday validation' do
    user = User.first
    assert_not user.update(birthday: Date.today()), 'should return a validation error'
    assert user.update(birthday: Date.today()-11.years), 'should update'
  end

end
