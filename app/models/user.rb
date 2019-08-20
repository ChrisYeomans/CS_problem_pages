require 'bcrypt'

class User < ApplicationRecord
	include Gravtastic
	gravtastic

	validates :name, presence: true, uniqueness: true, length: { in: 2..25 }	
	validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
	validates :password, presence: true, length: { minimum: 6 }, :if => :password
	validates :password_confirmation, presence: true, length: { minimum: 6 }, :if => :password
	has_secure_password

	has_many :submissions, :dependent => :destroy
	has_many :comments, :dependent => :destroy
end
