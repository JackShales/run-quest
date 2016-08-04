class CreateQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :quests do |t|
      t.string :name
      t.string :status
      t.string :type
      t.date :deadline
      t.integer :assigner_id
      t.integer :assignee_id

      t.timestamps
    end
  end
end
