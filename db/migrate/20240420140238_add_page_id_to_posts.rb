class AddPageIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :page_id, :integer
  end
end
