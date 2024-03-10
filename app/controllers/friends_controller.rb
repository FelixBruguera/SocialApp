class FriendsController < ApplicationController

    def new
        @friendship = Friend.new()
    end

    def create
        @friendship = Friend.new(friends_params)
        if @friendship.save
            request = FriendRequestsController.find_request(params[:user_id], params[:friend_id])
            FriendRequest.destroy(request)
            create_inverse_friendship
        end
    end

    private

    def friends_params
        params.permit(:user_id, :friend_id)
    end

    def create_inverse_friendship
        @friendship = Friend.new(user_id: params[:friend_id], friend_id: params[:user_id]).save
    end
end
