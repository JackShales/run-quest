class ChangeStatusToStatusCode < ActiveRecord::Migration[5.0]
  def change
    rename_column :quests, :status, :status_code
  end
end
