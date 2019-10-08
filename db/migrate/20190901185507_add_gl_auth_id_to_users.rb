class AddGlAuthIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gl_oauth_key, :string
  end
end
