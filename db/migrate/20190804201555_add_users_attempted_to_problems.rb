class AddUsersAttemptedToProblems < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :users_attempted, :integer
  end
end
