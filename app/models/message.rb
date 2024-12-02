class Message < ApplicationRecord
    include MessagesHelper

    belongs_to :user
    belongs_to :chat

    def broadcast(chat, user)
        broadcast_prepend_to "chat_#{chat.slug}", target: "messages_#{chat.slug}", partial: 'messages/message',
        locals: {user: user}
        broadcast_replace_to "chat_#{chat.slug}", target: "last-message-#{chat.slug}", partial: 'messages/last_message',
        locals: {date: self.created_at.strftime('%R'), chat: chat, user: user}
    end
end
