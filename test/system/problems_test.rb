require "application_system_test_case"

class ProblemsTest < ApplicationSystemTestCase
  test "create valid problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Problem Created"
  end

  test "create problem without title" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: ""
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Title can't be blank"
  end

  test "create problem without body" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: ""
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Body can't be blank"
  end

  test "create problem without test_cases" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: ""
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Test cases can't be blank"
  end

  test "create problem without CPU Time" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Problem Created"
  end

  test "create problem without CPU Memory" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Problem Created"
  end

  test "create problem without score" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Score can't be blank"
  end

  test "create problem with CPU Time blank" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: ""
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Cpu time can't be blank"
  end

  test "create problem with CPU memory blank" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: ""
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"

    assert_text "Memory can't be blank"
  end

  test "create current problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(true)
    find("#problem_is_hidden").set(false)

    click_on "Submit"
    visit "/current_problem"

    assert_text "test #01"
  end

  test "problem appears in past_problems" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)

    click_on "Submit"
    visit "/past_problems"

    assert_text "test #01"
  end

  test "hidden problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(true)

    click_on "Submit"
    visit "/past_problems"

    assert_no_text "test #01"
  end

  test "replace current problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(true)
    find("#problem_is_hidden").set(false)
    click_on "Submit"
    
    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #02"
    fill_in "Problem Statement", with: "test #02 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(true)
    find("#problem_is_hidden").set(false)
    click_on "Submit"
    
    visit "/current_problem"

    assert_no_text "test #01"
    assert_text "test #02"
  end

  test "change current problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(true)
    find("#problem_is_hidden").set(false)
    click_on "Submit"
    
    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #02"
    fill_in "Problem Statement", with: "test #02 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"
    
    click_on "Make Current Problem"
    page.driver.browser.switch_to.alert.accept

    visit "/current_problem"

    assert_no_text "test #01"
    assert_text "test #02"
  end

  test "remove current problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(true)
    find("#problem_is_hidden").set(false)
    click_on "Submit"
    
    click_on "Make Not Current Problem"
    page.driver.browser.switch_to.alert.accept

    visit "/current_problem"

    assert_no_text "test #01"
  end

  test "unhide hidden problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(true)
    click_on "Submit"
  
    click_on "Make Not Hidden"
    page.driver.browser.switch_to.alert.accept
    
    visit "/past_problems"

    assert_text "test #01"
  end

  test "hide unhidden problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"
  
    click_on "Make Hidden"
    page.driver.browser.switch_to.alert.accept
    
    visit "/past_problems"

    assert_no_text "test #01"
  end

  test "delete unhidden problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"
  
    click_on "Delete"
    page.driver.browser.switch_to.alert.accept
    
    visit "/past_problems"

    assert_no_text "test #01"
  end 

  test "delete current problem" do
    # first need to login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    visit "/dashboard/create_problem"

    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "test"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(true)
    find("#problem_is_hidden").set(false)
    click_on "Submit"
  
    click_on "Delete"
    page.driver.browser.switch_to.alert.accept
    
    visit "/current_problem"

    assert_no_text "test #01"
  end 

end
