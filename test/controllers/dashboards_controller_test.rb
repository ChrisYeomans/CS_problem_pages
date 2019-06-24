require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
	# These should be redirected as they are not logged in as an admin user
  test "should not get dashboards index" do
    get "/dashboard"
    assert_response :redirect, "Didn't get redirected from /dashboard"
	end

	test "should not get create problem" do
		get "/dashboard/create_problem"
		assert_response :redirect, "Didn't get redirected from /dashboard/create_problem"
	end

	test "should not get manage problems" do
		get "/dashboard/manage_problems"
		assert_response :redirect, "Didn't get redirected from /dashboard/manage_problems"
	end

	test "should not get manage users" do
		get "/dashboard/manage_users"
		assert_response :redirect, "Didn't get redirected from /dashboard/manage_users"
	end
end
