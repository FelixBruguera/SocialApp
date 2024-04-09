class UsersController < ApplicationController
    include UsersHelper
    include FriendRequestsHelper
    include PostsHelper
    include FriendsHelper

    before_action :resize, only: [:update]

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
        else
            p 'error creating'
        end
    end

    def show
        @countries = JSON.load(File.open('countries'))
        @user = User.friendly.find(params[:username])
        @friends = @user.friends.map {|friend| friend.friend_id}
        @photos = @user.posts.joins(:image_attachment).order('created_at DESC').take(6)
        @friendship = friendship_status(@user, current_user)
        @posts = @user.posts.paginate(page: 1, per_page: 10).order(created_at: :desc)
        respond_to do |format|
            format.turbo_stream do
                @posts = @posts.page(params[:page])
                render turbo_stream: turbo_stream.append("posts", partial: "posts/post", collection: @posts,
                    locals: {location: 'feed'})
            end
            format.html
        end
        
    end

    def update
        @user = User.friendly.find(params[:id])
        if @user == current_user
            if @user.update(update_params)
                redirect_to user_path(@user)
            else
                render @user, status: :unprocessable_entity
            end
        end
    end

    private

    def user_params
        params.permit(first_name, last_name, email, encrypted_password, bio, location, profile_picture, cover_picture, uuid, username)
    end

    def update_params
        params.require(:user).permit(:cover_picture, :profile_picture, :bio, :location, :current_password)
    end

    def resize
        if params[:user][:profile_picture].present?
            tempo = resize_before_save(params[:user][:profile_picture], 120, 120)
            params[:user][:profile_picture] = ActionDispatch::Http::UploadedFile.new(
                tempfile: tempo,
                filename: tempo.path,
                type: 'image/jpeg'
            )
        end
        if params[:user][:cover_picture].present?
            tempo = resize_before_save(params[:user][:cover_picture], 1100, nil)
            params[:user][:cover_picture] = ActionDispatch::Http::UploadedFile.new(
                tempfile: tempo,
                filename: tempo.path,
                type: 'image/jpeg'
            )
        end
    end
end

