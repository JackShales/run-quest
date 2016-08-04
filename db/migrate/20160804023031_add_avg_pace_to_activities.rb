class AddAvgPaceToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :avg_pace, :decimal, precision: 4, scale: 2
  end
end
