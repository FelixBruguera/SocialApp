class AddSeenToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :seen, :boolean
  end
end
