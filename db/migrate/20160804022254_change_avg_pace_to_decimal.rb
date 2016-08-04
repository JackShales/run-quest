class ChangeAvgPaceToDecimal < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :avg_pace, :time
  end
end
