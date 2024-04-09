module MessagesHelper

    def date(message)
        message.created_at.strftime('%D, %R')
    end
end
