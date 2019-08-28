require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit users_url
  #
  #   assert_selector "h1", text: "Users"
  # end

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
end
