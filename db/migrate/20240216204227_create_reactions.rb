class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.references :user
      t.references :post
      t.string :reaction
      t.timestamps
    end
  end
end
