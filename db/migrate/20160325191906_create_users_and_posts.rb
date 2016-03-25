class CreateUsersAndPosts < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
    end
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.integer :user_id
    end
  end

  def down
    drop_table :users
    drop_table :posts
  end

end
