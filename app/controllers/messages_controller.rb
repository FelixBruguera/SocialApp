class MessagesController < ApplicationController
    include ChatsHelper
    include UsersHelper

    def index
        @friends = current_user.friends.map {|friend| friend.friend }.uniq
        @chats = Chat.where(user_id: current_user.id).or(Chat.where(friend_id: current_user.id))
    end

    def new
        @message = Message.new
    end

    def create
        data = message_params
        if data[:user_id] == current_user.id
            id = data[:chat_id]
            chat = Chat.find(id)
            check_date = chat.messages.filter {|mes| mes.created_at.strftime("%D") == DateTime.now.strftime('%D')}
            if check_date.length == 0
                @message = Message.create(user_id: current_user.id, chat_id: id, body: DateTime.now.strftime('%D'), is_date: true)
                ActionCable.server.broadcast("ChatsChannel", {message: @message.body, is_date: true, chat_id: @message.chat.slug})
            end
            @message = Message.create(data)
            ActionCable.server.broadcast("ChatsChannel", {
            message: @message.body,
            chat_id: @message.chat.slug,
            current_user: current_user.slug,
            date: @message.created_at.strftime("%R")})
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
        @message = Message.find(params[:chat_id])
        @message.update
    end

    private

    def message_params
        params.require(:message).permit(:user_id, :chat_id, :body)
        {user_id: get_id(params[:message][:user_id]), chat_id: chat_id(params[:message][:chat_id]), 
        body: params[:message][:body]}
    end

end
