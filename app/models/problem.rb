class Problem < ApplicationRecord
	validates :title, presence: :true, uniqueness: true
	validates :cpu_time, presence: :true
	validates :memory, presence: :true
	validates :body, presence: :true
	validates :score, presence: :true
	validates :test_cases, presence: :true
	has_many :submissions, :dependent => :destroy
end
