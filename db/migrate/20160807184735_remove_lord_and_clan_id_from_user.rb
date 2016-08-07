class RemoveLordAndClanIdFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :lord, :boolean
    remove_column :users, :clan_id, :integer
  end
end
