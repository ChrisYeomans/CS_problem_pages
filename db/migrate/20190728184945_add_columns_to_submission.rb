class AddColumnsToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :verdict, :integer
    add_column :submissions, :results, :string
  end
end
