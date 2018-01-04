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
                                          password: 'Ha66y@Air' } }
    assert is_logged_in?
    assert_redirected_to employeeportal_dashboard_path
    follow_redirect!
    assert_template 'emp_sessions/show'
    assert_select "a[href=?]", employeeportal_login_path, count: 0
    assert_select "a[href=?]", employeeportal_logout_path
    assert_select "a[href=?]", employeeportal_dashboard_path
    delete employeeportal_logout_path
    assert_not is_logged_in?    
    assert_redirected_to employeeportal_login_path
    # Simulate a user clicking logout in a second window.
    delete employeeportal_logout_path
    follow_redirect!
    assert_select "a[href=?]", employeeportal_logout_path,      count: 0
  end

  test "login with remembering" do
    log_in_as(@employee, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@employee, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@employee, remember_me: '0')
    assert_empty cookies['remember_token']
  end

end
