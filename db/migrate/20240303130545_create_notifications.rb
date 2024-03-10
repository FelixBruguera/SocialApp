class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.integer :sender, null: false
      t.integer :receiver, null: false
      t.integer :post_id
      t.boolean :is_friend_request, default: false
      t.string :action, null: false
      t.boolean :seen, default: false
      t.timestamps
    end
  end
end
