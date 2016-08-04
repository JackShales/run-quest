class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :experience
      t.integer :speed
      t.integer :endurance
      t.integer :mental
      t.integer :level
      t.integer :clan_id
      t.boolean :lord

      t.timestamps
    end
  end
end
