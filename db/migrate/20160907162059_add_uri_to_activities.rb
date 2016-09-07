class AddUriToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :uri, :string
  end
end
