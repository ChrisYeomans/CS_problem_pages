require 'test_helper'

class ProblemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/problems"
    get "/index"
    get "/"
    assert_response :success, "Didn't get index"
  end

  test "should get past problems" do
  	get "/past_problems"
  	assert_response :success, "Didn't get past_problems"
  end

  test "should get current problem" do
  	get "/current_problem"
  	assert_response :success, "Didnt get current_problem"
  end

end
