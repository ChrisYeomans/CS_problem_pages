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

	def self.find_or_create_from_auth_hash(auth)
		where(gl_oauth_key: auth.uid).first_or_initialize.tap do |user|
			user.gl_oauth_key = auth.uid
			user.name = auth.info.first_name + " " + auth.info.last_name
			user.email = auth.info.email
			user.password = "123456"
			user.password_confirmation = "123456"
			user.save!
		end
	end
end
