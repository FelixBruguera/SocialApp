class CommentsController < ApplicationController
    include UsersHelper
    include PostsHelper

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params_edited)
        if @comment.user == current_user
            respond_to do |format|
                if @comment.save
                    poster = @comment.post.user
                    unless poster == @comment.user
                        Notification.create(sender:@comment.user, receiver: poster, post_id: @comment.post.id, action: 'commented')
                    end
                    format.turbo_stream do
                        render turbo_stream: turbo_stream.append("comments_#{@comment.post.slug}", partial: "comments/comment",
                            locals: { comment: @comment })
                    end
                else
                    format.turbo_stream do
                    end
                end
            end
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:post_id, :body)
    end

    def comment_params_edited
        data = comment_params
        data[:post_id] = Post.friendly.find(data[:post_id]).id
        data[:user_id] = current_user.id
        data
    end
end
