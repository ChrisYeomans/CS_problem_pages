require "application_system_test_case"

class SubmissionsTest < ApplicationSystemTestCase
  fixtures :all
  test "valid submission" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    # create problem
    visit "/dashboard/create_problem"
    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "***\nhello world"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"

    # make submission
    click_on "Make Submission"

    fill_in "Submission Code", with: "print('hello world')"
    click_on "Submit"

    # sleep to wait for ajax
    sleep 1

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "Wrong Answer" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    # create problem
    visit "/dashboard/create_problem"
    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "***\nhello world"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"

    # make submission
    click_on "Make Submission"

    fill_in "Submission Code", with: "print('hello world!!')"
    click_on "Submit"

    # sleep to wait for ajax
    sleep 1

    assert_text "Verdict: 0"
    assert_no_text "Verdict: 1"
  end

  test "runtime error" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    # create problem
    visit "/dashboard/create_problem"
    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "***\nhello world"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"

    # make submission
    click_on "Make Submission"

    fill_in "Submission Code", with: "print'hello world!!')"
    select("python3", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 1

    assert_text "Runtime Error"
  end

  test "compile error" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    # create problem
    visit "/dashboard/create_problem"
    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "***\nhello world"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"

    # make submission
    click_on "Make Submission"

    fill_in "Submission Code", with: "print'hello world!!')"
    select("c", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 1

    assert_text "Compile Error"
  end

  test "TLE" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    # create problem
    visit "/dashboard/create_problem"
    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "***\nhello world"
    fill_in "Max CPU Time", with: "1"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"

    # make submission
    click_on "Make Submission"

    fill_in "Submission Code", with: "while 1:\n    pass"
    select("python3", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 2

    assert_text "Time Limit Exceeded"
  end

  test "MLE" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    # create problem
    visit "/dashboard/create_problem"
    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "***\nhello world"
    fill_in "Max CPU Time", with: "2"
    fill_in "Max CPU Memory", with: "100m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"

    # make submission
    click_on "Make Submission"

    fill_in "Submission Code", with: "lst = []\nfor i in range(90000000000):\n    lst.append(i)"
    select("python3", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 2

    assert_text "Memory Limit Exceeded"
  end

  test "file upload valid" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    # create problem
    visit "/dashboard/create_problem"
    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "***\nhello world"
    fill_in "Max CPU Time", with: "1"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"

    # make submission
    click_on "Make Submission"

    attach_file("submission[upload]", Rails.root + "test/system/test_files/upload_test.py")
    select("python3", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 2

    assert_text "Verdict: 1"
    assert_no_text "Verdict: 0"
  end

  test "fork bomb" do
    # login as admin
    visit "/login"
    fill_in "Name", with: "admin"
    fill_in "Password", with: "123456"
    find('#submit-id-submit', :visible => true).click

    # create problem
    visit "/dashboard/create_problem"
    fill_in "Title", with: "test #01"
    fill_in "Problem Statement", with: "test #01 body"
    fill_in "Test Cases", with: "***\nhello world"
    fill_in "Max CPU Time", with: "4"
    fill_in "Max CPU Memory", with: "512m"
    fill_in "Score", with: "100"
    find("#problem_is_current").set(false)
    find("#problem_is_hidden").set(false)
    click_on "Submit"

    click_on "Make Submission"

    attach_file("submission[upload]", Rails.root + "test/system/test_files/f_bomb.c")
    select("c", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_text "Time Limit Exceeded"
  end

end
