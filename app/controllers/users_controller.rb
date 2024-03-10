class UsersController < ApplicationController

    def new
        @user = User.new()
    end

    def create
        @user = User.new(user_params)
        if @user.save
            p 'user created'
        else
            p 'error creating'
        end
    end

    def show
        redirect_to root_path
    end

    private

    def user_params
        params.permit(first_name, last_name, email, encrypted_password, bio, location, profile_picture)
    end
end
