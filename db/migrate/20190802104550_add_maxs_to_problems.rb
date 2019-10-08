class AddMaxsToProblems < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :memory, :string
    add_column :problems, :cpu_time, :string
  end
end
