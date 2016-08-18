class AddNotesTextToQuests < ActiveRecord::Migration[5.0]
  def change
    add_column :quests, :notes, :text
  end
end
