class DropMessagesTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :messages
  	drop_table :oauth_access_grants
  	drop_table :oauth_access_tokens
  	drop_table :oauth_applications
  	drop_table :posts
  end
end
