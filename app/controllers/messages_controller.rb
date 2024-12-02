class MessagesController < ApplicationController
    include ChatsHelper
    include UsersHelper
    include MessagesHelper

    def index
        @friends = current_user.friends.map {|friend| friend.friend }.uniq
        @chats = Chat.where(user_id: current_user.id).or(Chat.where(friend_id: current_user.id))
    end

    def new
        @message = Message.new
    end

    def create
        data = message_params_full
        id = data[:chat_id]
        chat = Chat.find(id)
        check_date = chat.messages.filter {|mes| mes.created_at.strftime("%D") == DateTime.current.strftime('%D')}
        if check_date.length == 0
            @message = Message.create(user_id: current_user.id, chat_id: id, body: DateTime.current.strftime('%D'), is_date: true, seen: true)
            @message.broadcast(chat, data[:user])
        end
        @message = Message.create(data.except(:user))
        @message.broadcast(chat, data[:user])
        respond_to do |format|
            format.turbo_stream do
                render turbo_stream: turbo_stream.replace("message-input", partial: "messages/message_input")
            end
        end
    end

    def show
        friendship = Friend.find(params[:id])
        if friendship.user == current_user
            @friend = friendship.friend
        else
            @friend = friendship.user
        end
        @messages = Message.where(chat_id: params[:id]).order('created_at ASC')
    end

    def update
        data = update_params_full
        messages = get_unseen(data[:chat_id], current_user.id)
        unless messages.nil?
            messages.each {|mes| mes.update(seen: true)}
        end
    end

    private

    def message_params
        params.require(:message).permit(:chat_id, :body, :seen, :user_id)
    end

    def message_params_full
        data = message_params
        data[:user_id] = User.friendly.find(data[:user_id]).id
        data[:user] = User.friendly.find(data[:user_id]).slug
        data[:chat_id] = Chat.friendly.find(data[:chat_id]).id
        data
    end

    def update_params
        params.permit(:chat_id)
    end

    def update_params_full
      data = update_params
      data[:chat_id] = Chat.friendly.find(data[:chat_id]).id
      data
    end

end
