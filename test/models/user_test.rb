require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user should save with valid fields" do
  	user = User.new
  	user.name = "Marco"
  	user.password = "1234abcd"
  	user.email = "marco@gmail.com"
  	assert user.save, "User should save with valid fields"
  end

  test "user should not save with empty fields" do
  	user = User.new
  	user.name = ""
  	user.password = "1234abcd"
  	user.email = "marco@gmail.com"
  	assert !user.save, "User saved with empty name"

  	user = User.new
  	user.name = "Marco"
  	user.password = ""
  	user.email = "marco@gmail.com"
  	assert !user.save, "User saved with empty password"

  	user = User.new
  	user.name = "Marco"
  	user.password = "1234abcd"
  	user.email = ""
  	assert !user.save, "User saved with empty email"
  end

  test "user should not save if duplicate fields" do
  	user = User.new
  	user.name = "Marco"
  	user.password = "1234abcd"
  	user.email = "marco@gmail.com"
  	user.save

  	user2 = User.new
  	user2.name = "Marco"
  	user2.password = "1234abcd5"
  	user2.email = "marco5@gmail.com"
  	assert !user2.save, "User should not save with duplicate name"

  	user3 = User.new
  	user3.name = "Marco5"
  	user3.password = "1234abcd5"
  	user3.email = "marco@gmail.com"
  	assert !user3.save, "User should not save with duplicate email"
  end

  test "name should be within set parameters" do
  	user = User.new
  	user.name = "M"
  	user.password = "1234abcd"
  	user.email = "marco@gmail.com"
  	assert !user.save, "Name should be longer than 1 letter"

  	user = User.new
  	user.name = "M"*26
  	user.password = "1234abcd"
  	user.email = "marco@gmail.com"
  	assert !user.save, "Name should be shorter than 26 letter"
  end

  test "email should be within set parameters" do
  	user = User.new
  	user.name = "Marco"
  	user.password = "1234abcd"
  	user.email = "m"*100 + "@gmail.com"
  	assert !user.save, "Email should be shorter than 100 letters"
	end

end
