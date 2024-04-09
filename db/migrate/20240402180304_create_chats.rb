class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.integer :user_id
      t.integer :friend_id
      t.timestamps
    end
  end
end
