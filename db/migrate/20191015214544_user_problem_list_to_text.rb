class UserProblemListToText < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :problem_list, :text
  end
end
