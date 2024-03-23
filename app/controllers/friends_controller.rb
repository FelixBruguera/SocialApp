class FriendsController < ApplicationController
    include FriendRequestsHelper
    def new
        @friendship = Friend.new()
    end

    def create
        @friendship = Friend.new(friends_params)
        if @friendship.save
            request = find_request(params[:user_id], params[:friend_id]).id
            FriendRequest.destroy(request)
            create_inverse_friendship
        end
    end

    def destroy
        @friendship = Friend.where(friends_params).first
        @friendship.destroy
        destroy_inverse_friendship
        redirect_to user_path(params[:friend_id])
    end

    private

    def friends_params
        params.permit(:user_id, :friend_id)
    end

    def create_inverse_friendship
        @friendship = Friend.new(user_id: params[:friend_id], friend_id: params[:user_id]).save
    end

    def destroy_inverse_friendship
        Friend.where(user_id: params[:friend_id], friend_id: params[:user_id]).first.destroy
    end
end
