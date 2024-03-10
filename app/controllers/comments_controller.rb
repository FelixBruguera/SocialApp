class CommentsController < ApplicationController

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params.except(:authenticity_token, :commit))
        respond_to do |format|
            if @comment.save
                poster = @comment.post.user
                unless poster == @comment.user
                    Notification.create(sender:@comment.user, receiver: poster, post_id: @comment.post.id, action: 'commented')
                end
                format.turbo_stream do
                    render turbo_stream: turbo_stream.append("comments_#{@comment.post.id}", partial: "comments/comment",
                        locals: { comment: @comment })
                end
            end
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :body)
    end
end
