class AddNumberOfTestCasesToProblem < ActiveRecord::Migration[5.2]
  def change
  	add_column :problems, :number_of_test_cases, :integer
  end
end
