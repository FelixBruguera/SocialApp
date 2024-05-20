class AddGuestToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_guest, :boolean
  end
end
