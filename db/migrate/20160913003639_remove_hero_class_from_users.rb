class RemoveHeroClassFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :hero_class, :string
  end
end
