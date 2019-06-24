require 'test_helper'

class ProblemTest < ActiveSupport::TestCase
	test "problem should save with valid fields" do
		problem = Problem.new
		problem.title = "Hello World1234"
		problem.body = "Hello World! program"
		problem.test_cases = "Hello World!"
		assert problem.save, "Problem didnt save with valid fields"
	end

  test "problem should not save with empty fields" do
		problem = Problem.new
		problem.title = ""
		problem.body = "Hello World! program"
		problem.test_cases = "Hello World!"
		assert !problem.save, "Problem saved with empty title"

		problem = Problem.new
		problem.title = "Hello World1234"
		problem.body = ""
		problem.test_cases = "Hello World!"
		assert !problem.save, "Problem saved with empty body"

		problem = Problem.new
		problem.title = "Hello World1234"
		problem.body = "Hello World! program"
		problem.test_cases = ""
		assert !problem.save, "Problem saved with empty test_cases"
  end

  test "problem should not save with duplicate title" do
  	problem = Problem.new
		problem.title = "Hello World1234"
		problem.body = "Hello World! program"
		problem.test_cases = "Hello World!"
		problem.save

		problem2 = Problem.new
		problem2.title = "Hello World1234"
		problem2.body = "Hello World! program5"
		problem2.test_cases = "Hello World!5"
		assert !problem2.save, "Problem saved with duplicate name"
  end

end