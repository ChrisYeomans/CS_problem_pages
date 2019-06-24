class Problem < ApplicationRecord
	validates :title, presence: :true, uniqueness: true
	validates :body, presence: :true
	validates :test_cases, presence: :true
end
