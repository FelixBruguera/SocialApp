class AddIsDateToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :is_date, :boolean
  end
end
