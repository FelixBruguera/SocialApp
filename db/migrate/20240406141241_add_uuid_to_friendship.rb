class AddUuidToFriendship < ActiveRecord::Migration[7.1]
  def change
    add_column :friends, :uuid, :uuid
    add_column :friends, :slug, :string
    add_index :friends, :slug, unique: true
  end
end
