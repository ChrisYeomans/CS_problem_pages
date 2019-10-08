class AddTotalUserScoreToProblem < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :total_user_score, :integer
  end
end
