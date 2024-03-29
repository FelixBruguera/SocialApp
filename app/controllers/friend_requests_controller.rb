class FriendRequestsController < ApplicationController

    def index
        user = User.find(current_user.id)
        @requests = user.friend_requests.order('created_at DESC')
    end

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

    private
    
    def friend_request_params
        params.permit(:sender, :receiver)
    end

    def update_params
        params.require(:friend_request).permit(:ignored)
    end
end
