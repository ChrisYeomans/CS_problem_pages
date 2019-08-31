require "application_system_test_case"

class PageAccessesTest < ApplicationSystemTestCase
  # This will test page access
  # for all of the pages on the 
  # website. It will make sure
  # that only users with the correct
  # permissions can access the 
  # relevant pages.
  
  test "comments not logged in" do
    visit "/comments/42"
    assert page.title == "CS problem Pages"
  end

  test "comments logged in normal user" do
    # login as regular user
    visit "/login"
    fill_in "Name", with: "bob"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/comments/42"
    assert page.title == "CS problem Pages"
  end

  test "comments logged in admin" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/comments/42"
    assert page.title == "comment"
  end

  test "dashboard not logged in" do
    visit "/dashboard"
    assert page.title == "CS problem Pages"

    visit "/dashboard/create_problem"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_comments"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_problems"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_solutions"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_submissions"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_users"
    assert page.title == "CS problem Pages"

    visit "/tcs"
    assert page.title == "Terms And Conditions"
  end

  test "dashboard logged in normal user" do
    # login as regular user
    visit "/login"
    fill_in "Name", with: "bob"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/dashboard"
    assert page.title == "CS problem Pages"

    visit "/dashboard/create_problem"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_comments"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_problems"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_solutions"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_submissions"
    assert page.title == "CS problem Pages"

    visit "/dashboard/manage_users"
    assert page.title == "CS problem Pages"

    visit "/tcs"
    assert page.title == "Terms And Conditions"
  end

  test "dashboard logged in admin" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard"
    assert page.title == "Dashboard"

    visit "/dashboard/create_problem"
    assert page.title == "Create Problem"

    visit "/dashboard/manage_comments"
    assert page.title == "Manage Comments"

    visit "/dashboard/manage_problems"
    assert page.title == "Manage Problems"

    visit "/dashboard/manage_solutions"
    assert page.title == "Manage Solutions"

    visit "/dashboard/manage_submissions"
    assert page.title == "Manage Submissions"

    visit "/dashboard/manage_users"
    assert page.title == "Manage Users"

    visit "/tcs"
    assert page.title == "Terms And Conditions"
  end

  test "problem solutions not logged in" do
    visit "/current_solution"
    assert page.title == "Solution Of The Week"

    visit "/problem_solutions/69/edit"
    assert page.title == "CS problem Pages"

    visit "problem_solutions/new"
    assert page.title == "CS problem Pages"

    visit "problem_solutions/69"
    assert page.title == "CS problem Pages"
  end

  test "problem solutions logged in regular user" do
    # login as regular user
    visit "/login"
    fill_in "Name", with: "bob"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/current_solution"
    assert page.title == "Solution Of The Week"

    visit "/problem_solutions/69/edit"
    assert page.title == "CS problem Pages"

    visit "problem_solutions/new"
    assert page.title == "CS problem Pages"

    visit "problem_solutions/69"
    assert page.title == "CS problem Pages"
  end

  test "problem solutions logged in admin" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/current_solution"
    assert page.title == "Solution Of The Week"

    visit "/problem_solutions/69/edit"
    assert page.title == "Edit Solution"

    visit "problem_solutions/new"
    assert page.title == "New Solution"

    visit "problem_solutions/69"
    assert page.title == "Show Solution"
  end

  test "problems not logged in" do
    visit "/current_problem"
    assert page.title == "Problem Of The Week"

    visit "/problems/1/edit"
    assert page.title == "CS problem Pages"

    visit "/problems/1"
    assert page.title == "hello world"
    
    visit "/past_problems"
    assert page.title == "Past Problems"

    visit "/"
    assert page.title == "CS problem Pages"
  end

  test "problems logged in regular user" do
    # login as regular user
    visit "/login"
    fill_in "Name", with: "bob"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/current_problem"
    assert page.title == "Problem Of The Week"

    visit "/problems/1/edit"
    assert page.title == "CS problem Pages"

    visit "/problems/1"
    assert page.title == "hello world"
    
    visit "/past_problems"
    assert page.title == "Past Problems"

    visit "/"
    assert page.title == "CS problem Pages"
  end

  test "problems logged in admin" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/current_problem"
    assert page.title == "Problem Of The Week"

    visit "/problems/1/edit"
    assert page.title == "Edit Problem"

    visit "/problems/1"
    assert page.title == "hello world"
    
    visit "/past_problems"
    assert page.title == "Past Problems"

    visit "/"
    assert page.title == "CS problem Pages"
  end

  test "submissions not logged in" do
    visit "/submissions/1/edit"
    assert page.title == "CS problem Pages"

    visit "/submissions/new"
    assert page.title == "CS problem Pages"
    
    visit "/submissions/1"
    assert page.title == "CS problem Pages"
  end

  test "submissions logged in regular user(owner of submission)" do
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/submissions/1/edit"
    assert page.title == "Edit Submission"

    visit "/submissions/new"
    assert page.title == "Create Submission"
    
    visit "/submissions/1"
    assert page.title == "Show Submission"
  end

  test "users not logged in" do
    visit "/login"
    assert page.title == "Login"

    visit "/user/new"
    assert page.title == "Signup"

    visit "/users/42"
    assert_text "Profile"

    visit "/users/42/comments"
    assert page.title == "CS problem Pages"

    visit "/users/42/settings"
    assert page.title == "CS problem Pages"
  end

  test "users logged in regular user(owner of stuff)" do
    visit "/login"
    fill_in "Name", with: "bob"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/login"
    assert page.title == "Login"

    visit "/user/new"
    assert page.title == "Signup"

    visit "/users/42"
    assert_text "Profile"

    visit "/users/42/comments"
    assert page.title == "User Comments"

    visit "/users/42/settings"
    assert_text "Profile"
  end

  test "users logged in regular user(not owner of stuff)" do
    visit "/login"
    fill_in "Name", with: "not_bob"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/login"
    assert page.title == "Login"

    visit "/user/new"
    assert page.title == "Signup"

    visit "/users/42"
    assert_text "Profile"

    visit "/users/42/comments"
    assert page.title == "CS problem Pages"

    visit "/users/42/settings"
    assert page.title == "CS problem Pages"
  end

  test "users logged in admin" do
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click
    assert_text "Successfully Logged in"

    visit "/login"
    assert page.title == "Login"

    visit "/user/new"
    assert page.title == "Signup"

    visit "/users/42"
    assert_text "Profile"

    visit "/users/42/comments"
    assert page.title == "User Comments"

    visit "/users/42/settings"
    assert page.title == "CS problem Pages"
  end
end
    