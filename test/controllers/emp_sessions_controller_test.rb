require 'test_helper'

class EmpSessionsControllerTest < ActionDispatch::IntegrationTest

  def setup 
    @employee = employees(:employee)
  end

  test "should get login" do
    get employeeportal_login_path
    assert_response :success
  end

  test "should get dashboard" do
    log_in_as @employee
    get employeeportal_dashboard_path
    assert_response :success
  end

end