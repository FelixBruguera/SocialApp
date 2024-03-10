class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :user
      t.references :post

      t.timestamps
    end
  end
end
