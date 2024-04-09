class AddUuidToFriendRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :friend_requests, :uuid, :uuid
    add_column :friend_requests, :slug, :string
    add_index :friend_requests, :slug, unique: true
  end
end
