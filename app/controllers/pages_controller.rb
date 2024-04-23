class PagesController < ApplicationController

    def index
        @pages = current_user.pages
    end

    def new
        @page = Page.new
    end

    def create
        @page = Page.create(page_params)
    end

    def show
        @page = Page.friendly.find(params[:id])
        @posts = @page.posts
    end

    def update
        @page = Page.friendly.find(params[:id])
        if @page.update(update_params)
            redirect_to @page
        end
    end

    private

    def page_params
        params.permit(:name, :description, :uuid, :user_id)
    end

    def update_params
        params.permit(:profile_picture, :cover_picture)
    end
end
