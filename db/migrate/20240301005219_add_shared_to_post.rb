class AddSharedToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :shared_post, :integer
  end
end
