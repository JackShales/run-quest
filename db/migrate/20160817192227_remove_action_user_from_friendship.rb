class RemoveActionUserFromFriendship < ActiveRecord::Migration[5.0]
  def change
    remove_column :friendships, :action_user_id, :integer
  end
end
