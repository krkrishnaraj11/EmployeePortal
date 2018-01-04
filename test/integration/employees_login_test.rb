require 'test_helper'

class EmployeesLoginTest < ActionDispatch::IntegrationTest


  def setup
    @employee = employees(:employee)
  end


  test "login with invalid information" do
    get employeeportal_login_path
    assert_template 'emp_sessions/new'
    post employeeportal_login_path, params: { session: { email: "", password: "" } }
    assert_template 'emp_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get employeeportal_login_path
    post employeeportal_login_path, params: { session: { username:    @employee.username,
                                          password: 'password' } }
    assert_redirected_to employeeportal_dashboard_path
    follow_redirect!
    # get  employeeportal_dashboard_path
    assert_template 'emp_sessions/show'
    assert_select "a[href=?]", employeeportal_login_path, count: 0
    assert_select "a[href=?]", employeeportal_logout_path
    assert_select "a[href=?]", employeeportal_dashboard_path
  end
end
