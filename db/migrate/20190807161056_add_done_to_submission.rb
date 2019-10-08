class AddDoneToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :done, :integer
  end
end
