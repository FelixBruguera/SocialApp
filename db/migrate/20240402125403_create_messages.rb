class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :chat_id
      t.string :body
      t.timestamps
    end
  end
end
