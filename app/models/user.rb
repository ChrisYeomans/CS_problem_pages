require 'bcrypt'

class User < ApplicationRecord
	validates :name, presence: true, uniqueness: true, length: { in: 2..25 }	
	validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
	validates :password, presence: true, length: { minimum: 6 }, :if => :password
	validates :password_confirmation, presence: true, length: { minimum: 6 }, :if => :password
	has_secure_password
end
