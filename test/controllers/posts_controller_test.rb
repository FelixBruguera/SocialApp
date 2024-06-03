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
end
