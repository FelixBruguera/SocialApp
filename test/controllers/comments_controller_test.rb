require "test_helper"
include Warden::Test::Helpers

class CommentsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'sending a comment' do
    login_as User.find(2)
    post comments_path(comment: {post_id: Post.first.slug, body: 'Testing comments'})
    assert Comment.last.body == 'Testing comments', 'it should create the comment'
    assert Comment.last.post == Post.first, 'the comment should link to the post'
    assert Comment.last.user = User.find(2), 'the comment should link to the user'
  end
  test 'empty comment' do
    login_as User.find(2)
    post comments_path(comment: {post_id: Post.first.slug, body: ''})
    assert_response :not_acceptable, 'it should not create the comment'
  end

end
