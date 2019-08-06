class AddScoreToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :score, :integer
  end
end
