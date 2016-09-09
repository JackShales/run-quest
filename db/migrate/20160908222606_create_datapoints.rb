class CreateDatapoints < ActiveRecord::Migration[5.0]
  def change
    create_table :datapoints do |t|
      t.integer :activity_id
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6

      t.timestamps
    end
  end
end
