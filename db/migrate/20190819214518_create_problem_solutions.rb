class CreateProblemSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_solutions do |t|
      t.text :solution
      t.integer :problem_id

      t.timestamps
    end
  end
end
