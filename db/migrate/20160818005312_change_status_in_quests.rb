class ChangeStatusInQuests < ActiveRecord::Migration[5.0]
  def change
    change_column :quests, :status, 'integer USING CAST(status AS integer)'
  end
end
