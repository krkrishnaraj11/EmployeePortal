require 'test_helper'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  
  def setup 
    @employee = employees(:employee)
  end

  test "should get root" do
    get root_path
    assert_response :redirect
    assert_redirected_to employeeportal_login_path
  end

  test "should get edit" do
    log_in_as @employee
    get employeeportal_path
    assert_response :success
  end



end
