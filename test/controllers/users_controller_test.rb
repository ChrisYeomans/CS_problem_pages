require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get "/users/new"
    assert_response :success, "Didn't get /users/new"
  end

  test "should get login" do
  	get "/login"
  	assert_response :success, "Didnt get /login"
  end

end
