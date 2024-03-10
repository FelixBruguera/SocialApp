class FriendRequestsController < ApplicationController

    def new
        @friend_request = FriendRequest.new
    end
    
    def create
        @friend_request = FriendRequest.create(friend_request_params)
        head :ok
    end

    def update
        @friend_request = FriendRequest.find(params[:id])
        @friend_request.update(update_params)
    end

    def destroy
        @friend_request = FriendRequest.find(params[:id])
        @friend_request.destroy
    end

    def self.find_request(user_id, friend_id)
        @request = FriendRequest.where(sender: user_id, receiver: friend_id)
        if @request.exists?
            @request
        else
            FriendRequest.where(sender: friend_id, receiver: user_id)
        end
    end

    private
    
    def friend_request_params
        params.permit(:sender, :receiver)
    end

    def update_params
        params.require(:friend_request).permit(:ignored)
    end
end
