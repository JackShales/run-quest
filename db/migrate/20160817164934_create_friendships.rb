class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :status_code
      t.integer :action_user_id

      t.timestamps
    end
  end
end
