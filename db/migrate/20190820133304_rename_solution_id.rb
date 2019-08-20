class RenameSolutionId < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :solution_id, :problem_solution_id
  end
end
