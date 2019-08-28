require "application_system_test_case"

class LanguagesTest < ApplicationSystemTestCase
  test "python3" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/python3_test.py")
    select("python3", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 1

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "python2" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/python2_test.py")
    select("python2", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 1

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "c" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/c_test.c")
    select("c", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 1

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "c++11" do
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

    # make submissions
    click_on "Make Submission"

    attach_file("submission[upload]", Rails.root + "test/system/test_files/cpp11_test.cpp")
    select("cpp11", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "cpp14" do
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

    click_on "Make Submission"

    attach_file("submission[upload]", Rails.root + "test/system/test_files/cpp14_test.cpp")
    select("cpp14", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "cpp17" do
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

    click_on "Make Submission"

    attach_file("submission[upload]", Rails.root + "test/system/test_files/cpp17_test.cpp")
    select("cpp17", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "java6" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/java6_test.java")
    select("java6", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "java7" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/java7_test.java")
    select("java7", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "java8" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/java8_test.java")
    select("java8", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "java9" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/java9_test.java")
    select("java9", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "java10" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/java10_test.java")
    select("java10", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "java11" do
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

    attach_file("submission[upload]", Rails.root + "test/system/test_files/java11_test.java")
    select("java11", from: "submission_language")
    click_on "Submit"

    # sleep to wait for ajax
    sleep 4

    assert_no_text "Verdict: 0"
    assert_text "Verdict: 1"
  end

  test "go" do

  end

  test "rust" do

  end

  test "v" do

  end

  test "ruby" do

  end
end
