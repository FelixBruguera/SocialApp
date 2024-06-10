require "test_helper"
include Warden::Test::Helpers

class UsersControllerTest < ActionDispatch::IntegrationTest
  User.first.update(profile_picture: File.open('test/fixtures/files/pfp.jpg'))
  User.first.update(cover_picture: File.open('test/fixtures/files/cover_default.jpg'))
  User.find(2).update(profile_picture: File.open('test/fixtures/files/pfp.jpg'))
  User.find(2).update(cover_picture: File.open('test/fixtures/files/cover_default.jpg'))
  User.find(3).update(profile_picture: File.open('test/fixtures/files/pfp.jpg'))
  User.find(4).update(cover_picture: File.open('test/fixtures/files/cover_default.jpg'))
  User.find(4).update(profile_picture: File.open('test/fixtures/files/pfp.jpg'))

  test 'getting the current user' do
    login_as User.first
    get '/current_user'
    assert_response :success
    json_response = JSON.parse(response.body)['user']
    assert json_response == User.first.username
  end

  test 'getting the current user without sign in' do
    get '/current_user'
    assert_response :redirect
  end

  test 'getting a users profile as another user' do
    login_as User.first
    get user_path(User.find(2).slug)
    assert_select 'img#user-profile-pic', 1
    assert_select 'img.cover-pic', 1
    assert_select '#profile-bio', text: User.find(2).bio
    assert_select '#posts', 0
    assert_select '.post-feed', 0
  end

  test 'getting a users profile as a friend' do
    login_as User.find(3)
    get user_path(User.first.slug)
    assert_select 'img#user-profile-pic', 1
    assert_select 'img.cover-pic', 1
    assert_select '#profile-bio', text: User.first.bio
    assert_select 'button.button', text: 'Friends'
    assert_select '#posts', 1
    assert_select '.post-feed', {:minimum => 1}
  end

  test 'signing out as a guest' do
    login_as User.find(4)
    post posts_path(post: {body: 'Testing destroy'})
    post comments_path(comment: {post: Post.first.slug, body: 'Testing a comment'})
    post reactions_path(post reactions_path(post_id: Post.find(2).slug))
    delete destroy_user_session_path
    assert User.where(id: 4).empty?, 'it should delete the user'
    assert Post.where(user_id: 4).empty?, 'it should delete the users posts'
    assert Comment.where(user_id: 4).empty?, 'it should delete the users comments'
    assert Reaction.where(user_id: 4).empty?, 'it should delete the users reactions'
  end

  test 'signing out as an user' do
    login_as User.first
    delete destroy_user_session_path
    assert_not User.where(id: 1).empty?, 'it should not delete the user'
    assert_not Post.where(user_id: 1).empty?, 'it should not delete the users posts'
    assert_not Comment.where(user_id: 1).empty?, 'it should not delete the users comments'
    assert_not Reaction.where(user_id: 1).empty?, 'it should not delete the users reactions'
  end

  test 'login as a guest' do
    get '/guest?is_guest=true'
    assert User.last.first_name == 'Guest', 'it should create the user'
    assert User.last.is_guest == true, 'the user should be a guest'
    sleep 2.minutes
    assert_not User.last.first_name == 'Guest', 'it should destroy the user'
  end
end
