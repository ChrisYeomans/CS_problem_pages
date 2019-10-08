class AddIsFeaturedToProblemSolution < ActiveRecord::Migration[5.2]
  def change
    add_column :problem_solutions, :is_featured, :integer
  end
end
