class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :quest_id
      t.decimal :distance, precision: 5, scale: 2
      t.time :time
      t.time :avg_pace
      t.integer :calories
      t.string :status

      t.timestamps
    end
  end
end
