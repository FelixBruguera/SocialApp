class ChangeStatusOnFriendRequest < ActiveRecord::Migration[7.1]
  def change
    remove_column :friend_requests, :status
    add_column :friend_requests, :ignored, :boolean, :default => false
  end
end
