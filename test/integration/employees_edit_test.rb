require 'test_helper'

class EmployeesEditTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:employee)
  end

  test "unsuccessful edit" do
    log_in_as @employee
    get employeeportal_path(@employee)
    assert_template 'employees/edit'
    patch employeeportal_path(:id => @employee.id), params: { employee: { phone:  "",
                                              personal_email: "foo@invalid"} }

    assert_template 'employees/edit'
  end

  test "successful edit" do
    log_in_as @employee
    get employeeportal_path(@employee)
    assert_template 'employees/edit'
    phone  = 9496088769
    email = "nikhildanand@hotmail.com"
    patch employeeportal_path(:id => @employee.id), params: { employee: { phone:  phone,
                                              personal_email: email} }
    assert_not flash.empty?
    assert_redirected_to employeeportal_dashboard_path
    @employee.reload
    assert_equal phone,  @employee.phone
    assert_equal email, @employee.personal_email
  end
end
