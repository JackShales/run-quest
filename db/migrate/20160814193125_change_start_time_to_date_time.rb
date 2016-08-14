class ChangeStartTimeToDateTime < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :start_time, :time
  end
end
