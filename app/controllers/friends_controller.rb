class FriendsController < ApplicationController
    include FriendRequestsHelper
    include FriendsHelper
    include UsersHelper

    def new
        @friendship = Friend.new()
    end

    def create
        users = friends_params
        @friendship = Friend.new(users)
        if @friendship.save
            request = find_request(users[:user_id], users[:friend_id]).id
            FriendRequest.destroy(request)
            create_chat(users[:user_id], users[:friend_id])
            create_inverse_friendship(users)
        end
    end

    def destroy
        @friendship = Friend.friendly.find(params[:id])
        users = {user_id: @friendship.user_id, friend_id: @friendship.friend_id}
        @friendship.destroy
        destroy_inverse_friendship(users)
        redirect_to user_path(params[:friend_id], data: {turbo:false})
    end

    private

    def friends_params
        params.permit(:user_id, :friend_id, :id, :uuid)
        {user_id: get_id(params[:user_id]), friend_id: get_id(params[:friend_id]), id: params[:id], 
        uuid: SecureRandom.uuid}
    end

    def create_inverse_friendship(users)
        @friendship = Friend.new(user_id: users[:friend_id], friend_id: users[:user_id], uuid: SecureRandom.uuid).save
    end

    def destroy_inverse_friendship(users)
        Friend.where(user_id: users[:friend_id], friend_id: users[:user_id]).first.destroy
    end
end
