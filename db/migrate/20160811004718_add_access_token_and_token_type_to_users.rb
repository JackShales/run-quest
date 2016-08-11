class AddAccessTokenAndTokenTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :access_token, :string
    add_column :users, :token_type, :string
  end
end
