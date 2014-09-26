class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :provider
      t.string :name
      t.string :email
      t.string :username
      t.string :gender
      t.date :dob
      t.string :uid
      t.string :image
      t.string :access_token
      t.string :access_token_secret
      t.string :state
      t.references :user

      t.timestamps
    end
    add_index :accounts, :user_id
  end
end
