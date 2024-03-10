class CreateFriendRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :friend_requests do |t|
      t.string :sender
      t.string :receiver
      t.string :status
      t.timestamps
    end
  end
end
