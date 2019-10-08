class AddScoreToProblems < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :score, :integer
  end
end
