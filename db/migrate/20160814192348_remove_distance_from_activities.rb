class RemoveDistanceFromActivities < ActiveRecord::Migration[5.0]
  def change
    remove_column :activities, :distance, :decimal
  end
end
