require "application_system_test_case"

class SubmissionsTest < ApplicationSystemTestCase
  fixtures :all
  test "valid hello world submission with python3" do
    # login as regular user
    visit "/login"
    fill_in "Name", with: "bob"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/problems/2"
    click_on "Make Submission"
  end
end
