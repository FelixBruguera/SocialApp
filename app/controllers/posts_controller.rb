class PostsController < ApplicationController

    def index
        friends = current_user.friends.map {|friend| friend.friend_id}
        @feed = Post.where(user_id: friends).or(Post.where(user_id: current_user)).order(created_at: :desc)
        @people = User.where.not(id: friends).and(User.where.not(id:current_user))
        @people = @people.filter {|person| FriendRequestsController.find_request(current_user, person).empty? }
        unless @people.empty? then @people end
    end

    def new
         @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            unless @post.shared_post.nil?
                poster = Post.find(@post.shared_post).user
                unless poster == @post.user
                    Notification.create(sender:@post.user, receiver: poster, post_id: @post.shared_post, action: 'shared')
                end
            end
            redirect_to root_path
        else
            render root_path, status: :unprocessable_entity
        end
    end

    private
    
    def post_params
        params.permit(:body, :user_id, :image, :shared_post)
    end
end
