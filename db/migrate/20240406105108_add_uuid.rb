class AddUuid < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uuid, :uuid
    add_column :users, :username, :string
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
    add_column :posts, :uuid, :uuid
    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true
    add_column :chats, :uuid, :uuid
    add_column :chats, :slug, :string
    add_index :chats, :slug, unique: true
  end
end
