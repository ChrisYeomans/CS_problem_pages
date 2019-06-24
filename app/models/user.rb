class User < ApplicationRecord
	validates :name, presence: true, uniqueness: true, length: { in: 2..25 }	
	validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
	validates :password, presence: true
end
