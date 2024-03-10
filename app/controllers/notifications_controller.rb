class NotificationsController < ApplicationController

    def new
        @notification = Notification.new
    end

    def create
        @notification = Notification.create(notification_params)
    end

    def update_notifications
        @notifications = current_user.notifications
        @notifications.update_all('seen': true)
        head :ok
    end

    private

    def notification_params
        params.permit(:sender, :receiver, :post_id, :is_friend_request, :type, :seen)
    end
end
