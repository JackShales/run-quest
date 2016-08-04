class CreateClanQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :clan_quests do |t|
      t.integer :clan_id
      t.integer :quest_id

      t.timestamps
    end
  end
end
