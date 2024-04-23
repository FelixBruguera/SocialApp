class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :description
      t.uuid :uuid
      t.integer :user_id
      t.string :slug
      t.timestamps
    end
  end
end
