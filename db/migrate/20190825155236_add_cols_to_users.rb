class AddColsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gh_oauth_key, :string
    add_column :users, :fb_oauth_key, :string
  end
end
