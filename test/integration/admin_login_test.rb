require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest

  def setup
    @employee = employees(:employee)
    @admin = employees(:admin)
  end


  test "login with invalid information" do
    get admin_login_path
    assert_template 'employees/adminlogin'
    post admin_login_path, params: { session: { username: "", password: "" } }
    assert_redirected_to admin_login_path
    assert_not flash.empty?
  end

  test "admin login with employee details" do
    get admin_login_path
    assert_template 'employees/adminlogin'
    post admin_login_path, params: { session: { username: @employee.username, password: @employee.password } }
    assert_redirected_to admin_login_path
    assert_not flash.empty?
  end

  test "login with valid information" do
    get admin_login_path
    log_in_as @admin
    assert is_logged_in?
    assert is_admin?
    get admin_dashboard_path
    assert_template 'employees/admindashboard'
    assert_select "a[href=?]", admin_login_path, count: 0
    delete admin_logout_path
    assert_not is_logged_in?
    assert_redirected_to employeeportal_login_path
    # # Simulate a user clicking logout in a second window.
    delete admin_logout_path
    follow_redirect!
    assert_select "a[href=?]", admin_logout_path,      count: 0
  end

  test "login with remembering" do
    log_in_as(@admin, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@admin, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@admin, remember_me: '0')
    assert_empty cookies['remember_token']
  end

end
