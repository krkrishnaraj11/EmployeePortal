require 'test_helper'

class EmployeesPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get employees_pages_home_url
    assert_response :success
  end

  test "should get dashboard" do
    get employees_pages_dashboard_url
    assert_response :success
  end

end