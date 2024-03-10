class ReactionsController < ApplicationController

    def new
        @reaction = Reaction.new(reaction_params)
    end

    def create
        @reaction = Reaction.new(reaction_params)
        if @reaction.save
            poster = Post.find(params[:post_id]).user
            unless poster == @reaction.user
                Notification.create(sender:@reaction.user, receiver: poster, post_id: @reaction.post.id, action: 'liked')
            end
        else
            Reaction.destroy(Reaction.where(user_id: reaction_params[:user_id], post_id: reaction_params[:post_id]))
        end
    end

    private
    
    def reaction_params
        params.permit(:user_id, :post_id, :reaction)
    end
end
