require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "making a new user" do
    visit "/user/new"
    
    fill_in "Name", with: "New_bob"
    fill_in "Email", with: "new_bob@test.com"
    fill_in "Password", with: "123456"
    fill_in "Password Confirmation", with: "123456"

    find('#submit-id-submit', :visible => true).click

    assert_text "New_bob"
  end

  test "making a new user with no email" do
    visit "/user/new"
    
    fill_in "Name", with: "New_bob"
    fill_in "Email", with: ""
    fill_in "Password", with: "123456"
    fill_in "Password Confirmation", with: "123456"

    find('#submit-id-submit', :visible => true).click

    assert_text "New_bob"
  end

  test "making a new user with no password" do
    visit "/user/new"
    
    fill_in "Name", with: "New_bob"
    fill_in "Email", with: "bob@test.com"
    fill_in "Password", with: ""
    fill_in "Password Confirmation", with: ""

    find('#submit-id-submit', :visible => true).click

    assert_text "Signup"
  end

  test "making a new user with not matching password" do
    visit "/user/new"
    
    fill_in "Name", with: "New_bob"
    fill_in "Email", with: "bob@test.com"
    fill_in "Password", with: "123456"
    fill_in "Password Confirmation", with: ""

    find('#submit-id-submit', :visible => true).click

    assert_text "Signup"
  end

  test "logging in a regular user" do
    visit "/login"

    fill_in "Name", with: "bob"
    fill_in "Password", with: "123456"

    find('#submit-id-submit', :visible => true).click

    assert_text "bob"
  end

  test "logging in an admin user" do
    visit "/login"

    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"

    find('#submit-id-submit', :visible => true).click

    assert_text "admin"
  end
end
