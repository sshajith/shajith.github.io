class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.datetime :scheduled_on
      t.string :url
      t.text :account_ids
      t.string :category
      t.string :state
      t.references :user

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
