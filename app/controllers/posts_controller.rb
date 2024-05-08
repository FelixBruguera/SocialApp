class PostsController < ApplicationController
    include FriendRequestsHelper
    include PostsHelper
    before_action :resize, only: [:create]

    def index
        friends = current_user.friends.map {|friend| friend.friend_id}
        @feed = Post.where(user_id: friends).or(Post.where(user_id: current_user)).or(Post.where.not(page_id: nil)).paginate(page: 1, per_page: 10).order(created_at: :desc)
        @people = User.where.not(id: friends).and(User.where.not(id:current_user))
        @people = @people.filter {|person| find_request(current_user, person).nil? }
        unless @people.empty? then @people = @people.take(3) end
        respond_to do |format|
            format.turbo_stream do
                @feed = @feed.page(params[:page])
                render turbo_stream: turbo_stream.append("posts", partial: "posts/post", collection: @feed,
                    locals: {location: 'feed'})
            end
            format.html
        end
    end

    def new
         @post = Post.new
    end

    def welcome
        @user = current_user
    end

    def create
        data = post_params
        if data[:page_id].present?
            data[:page_id] = Page.friendly.find(data[:page_id]).id
        else
            data[:user_id] =  current_user.id
        end
        data[:uuid] = SecureRandom.uuid
        unless data[:shared_post].nil?
          data[:shared_post] = Post.friendly.find(data[:shared_post]).id
        end
        @post = Post.new(data)
        unless @post.user == current_user || @post.page.user == current_user
            return render root_path, status: :unprocessable_entity
        end
        if @post.save
            unless @post.shared_post.nil?
                poster = Post.find(@post.shared_post).user
                unless poster == @post.user
                    Notification.create(sender:@post.user, receiver: poster, post_id: @post.shared_post, action: 'shared')
                end
            end
            respond_to do |format|
                format.turbo_stream do
                    render turbo_stream: turbo_stream.prepend("posts", partial: "posts/post",
                        locals: { post: @post, location: 'feed', is_page: @post.page_id})
                end
            end
        else
            render root_path, status: :unprocessable_entity
        end
    end

    def update
        @post = Post.friendly.find(params[:id])
        if @post.update(update_params)
        else
            render @post, status: :unprocessable_entity
        end
    end

    private

    def resize
        if params[:post][:image].present?
            tempo = resize_before_save(params[:post][:image], 810, 500)
            params[:post][:image] = ActionDispatch::Http::UploadedFile.new(
                tempfile: tempo,
                filename: tempo.path,
                type: 'image/jpeg'
            )
        end
    end

    def post_params
        params.require(:post).permit(:body, :image, :shared_post, :uuid, :page_id, :user_id)
    end

    def update_params
        params.require(:post).permit(:image)
    end
end
