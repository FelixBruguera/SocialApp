class ReactionsController < ApplicationController
    include UsersHelper
    include PostsHelper

    def new
        @reaction = Reaction.new(reaction_params)
    end

    def create
        data = reaction_params
        data[:user_id] = current_user.id
        data[:post_id] = Post.friendly.find(data[:post_id]).id
        data[:reaction] = 'like'
        @reaction = Reaction.new(data)
        if @reaction.save
            poster = @reaction.post.user
            unless poster == @reaction.user
                Notification.create(sender:@reaction.user, receiver: poster, post_id: data[:post_id], action: 'liked')
            end
        else
            Reaction.destroy(Reaction.where(user_id: data[:user_id], post_id: data[:post_id]))
        end
    end

    private

    def reaction_params
        params.permit(:post_id)
    end
end
