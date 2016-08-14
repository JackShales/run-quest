class RemoveEndTimeFromActivities < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :end_time, :time
  end
end
