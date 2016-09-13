class AddBioAndClassToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :hero_class, :string
  end
end
