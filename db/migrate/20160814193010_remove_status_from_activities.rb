class RemoveStatusFromActivities < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :status, :string
  end
end
