class ChangeTimeToStartTimeAndAddEndTimeToActivity < ActiveRecord::Migration[5.0]
  def change
    rename_column :activities, :time, :start_time
    add_column :activities, :end_time, :time
  end
end
