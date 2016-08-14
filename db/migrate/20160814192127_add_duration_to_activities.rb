class AddDurationToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :duration, :decimal, precision: 8, scale: 3
  end
end
