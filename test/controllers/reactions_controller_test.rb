require "test_helper"
include Warden::Test::Helpers

class ReactionsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'reacting to a post' do
    login_as User.first
    post reactions_path(post_id: Post.find(2).slug)
    assert_not Post.find(2).reactions.first.nil?, 'it should create the reaction'
    assert Reaction.last.post == Post.find(2), 'the reaction should link to the post'
    assert Reaction.last.user == User.first, 'the reaction should link to the user'
  end

  test 'unreacting to a post' do
    login_as User.first
    post reactions_path(post_id: Post.first.slug)
    assert Reaction.where(user_id: 1).and(Reaction.where(post_id: 1)).empty?, 'it should delete the reaction'
  end
  
end
