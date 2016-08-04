class ChangeTypeToQuestTypeInQuests < ActiveRecord::Migration[5.0]
  def change
    rename_column :quests, :type, :quest_type
  end
end
