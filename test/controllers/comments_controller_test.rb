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

  test 'rendering a comment' do
    login_as User.first
    User.first.update(profile_picture: File.open('test/fixtures/files/pfp.jpg'))
    get post_path(Post.first.slug)
    assert_select '.comment', {:minimum=> 1}
    assert_select '.comment-user', User.first.first_name+' '+User.first.last_name
    assert_select '.comment>.user-pic>.user-date>p', 'Testing'
  end

end
