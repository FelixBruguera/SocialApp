require "test_helper"
include Warden::Test::Helpers

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'making a post' do
    login_as User.first
    post posts_path(post: {body: 'Testing'})
    assert Post.last.body == 'Testing', 'it should create the post'
    assert Post.last.user == User.first, 'the post should link to the poster'
  end

  test 'sharing a post' do
    login_as User.first
    post posts_path(post: {body: 'Testing shares', shared_post: 2})
    assert Post.last.body == 'Testing shares', 'it should create the post'
    assert Post.last.user == User.first, 'the post should link to the poster'
    assert Post.find(2).shares.first == Post.last, 'the post should link to the shared post'
  end

  test 'rendering a post' do
    login_as User.first
    User.first.update(profile_picture: File.open('test/fixtures/files/pfp.jpg'))
    get post_path(Post.first.slug)
    assert_select '.post', 1
    assert_select '.post-user', User.first.first_name+' '+User.first.last_name
    assert_select '.post-body', 'testing post'
    assert_select '#reactions', 1
    assert_select '#comments-count', 1
    assert_select '#share', 1
    assert_select "#comments_#{Post.first.slug}", 1
  end

  test 'rendering a shared post' do
    login_as User.first
    User.first.update(profile_picture: File.open('test/fixtures/files/pfp.jpg'))
    get post_path(Post.find(2).slug)
    assert_select '.post', 1
    assert_select '.shared_post', 1
    assert_select '.post-user', User.first.first_name+' '+User.first.last_name
    assert_select '.post>.link-post>.post-body', 'testing shares'
    assert_select '.shared_post>.link-post>.post-body', 'testing post'
    assert_select '#reactions', 1
    assert_select '#comments-count', 1
    assert_select '#share', 1
    assert_select "#comments_#{Post.find(2).slug}", 1
  end

  test 'rendering posts index' do
    login_as User.first
    get posts_path
    assert_select '#feed', 1
    assert_select '#posts', 1
    assert_select '.post-feed', :minimum => 1
    assert_select '.post-body', text: 'testing post'
  end
end
