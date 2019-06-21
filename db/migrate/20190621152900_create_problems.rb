class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.string :title
      t.text :body
      t.integer :is_current
      t.text :test_cases

      t.timestamps
    end
  end
end
