class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.text :code
      t.string :language
      t.string :extension
      t.integer :problem_id
      t.integer :user_id
      t.integer :test_cases_passed

      t.timestamps
    end
  end
end
