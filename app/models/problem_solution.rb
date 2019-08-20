class ProblemSolution < ApplicationRecord
    has_many :comments, :dependent => :destroy
    belongs_to :problem
end
