class ApplicationController < ActionController::Base
    #before_action :authenticate_user!
    def index
        if user_signed_in? 
            redirect_to '/posts#index'
        else
            render 'layouts/index'
        end
    end
end
