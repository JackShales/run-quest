class AddActionUserToFriendships < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :action_user_id, :integer
  end
end
