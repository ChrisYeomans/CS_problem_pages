require 'bcrypt'

class User < ApplicationRecord
	include Gravtastic
	gravtastic

	validates :name, presence: true, length: { in: 2..25 }	
	validates :password, presence: true, length: { minimum: 6 }, :if => :password
	validates :password_confirmation, presence: true, length: { minimum: 6 }, :if => :password
	has_secure_password

	has_many :submissions, :dependent => :destroy
	has_many :comments, :dependent => :destroy
end
