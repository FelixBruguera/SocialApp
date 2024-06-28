require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'empty body' do
    post = Post.new(user_id: 1, body: '')
    assert_not post.save, 'it should return an empty body error'
  end

  test 'comment relationship' do
    post = Post.first
    assert_not post.comments.empty?, 'it should get comments'
    assert post.comments.first.post == post, 'the comment should be linked to the post'
  end

  test 'user relationship' do
    post = Post.first
    assert_not post.user.nil?, 'it should get the poster'
  end

  test 'shared posts' do
    post = Post.first
    assert_not post.shares.nil?, 'it should get the shared posts'
    assert post.shares.first.shared_post == post, 'shared post should link to the original post'
  end

  test 'reactions relationship' do
    post = Post.first
    assert_not post.reactions.nil?, 'it should get post reactions'
    assert post.reactions.first.post == post, 'reaction should link to post'
  end
end
