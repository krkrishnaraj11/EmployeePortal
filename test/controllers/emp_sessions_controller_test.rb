require 'test_helper'

class EmpSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get employeeportal_login_path
    assert_response :success
  end

end