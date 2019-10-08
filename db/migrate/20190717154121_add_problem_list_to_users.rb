class AddProblemListToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :problem_list, :string
  end
end
