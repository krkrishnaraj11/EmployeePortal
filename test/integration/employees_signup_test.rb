require 'test_helper'

class EmployeesSignupTest < ActionDispatch::IntegrationTest

  def setup
    @admin = employees(:admin)
    @employee = employees(:employee)
  end

  test "invalid signup information" do
    log_in_as @admin
    get admin_addemployee_path
    assert_no_difference 'Employee.count' do
      post admin_addemployee_path, params: { employee: { name:  "",
                                         gender: "hjkadsg",
                                         designation: "dhf",
                                         phone: 12345678,
                                         date_of_join: 2017-22-22,
                                         email: "user@invalid",
                                         username: "invalid",
                                         password: "password",
                                         password_confirmation: "pass" } }
    end
    assert_template 'employees/addemployee'
  end

  test "valid signup information" do
    log_in_as @admin
    get admin_addemployee_path
    assert_difference 'Employee.count', 1 do
      post admin_addemployee_path, params: { employee: { name:  "Vishnu Raj",
                                         gender: "Male",
                                         designation: "Developer",
                                         phone: 8585858585,
                                         date_of_join: "2017-05-06",
                                         date_of_birth: "1997-05-06",
                                         address: "Sajith Nivas, Karumalloor P.O, Thattampady, Aluva",
                                         personal_email: "vishnuraj2@gmail.com",
                                         email: "vishnuraj@gmail.com",
                                         username: "vishnuraj@gmail.com",
                                         active: true,
                                         password: "Ha66y@Air",
                                         password_confirmation: "Ha66y@Air" } }
    end
    follow_redirect!
    assert_template 'employees/employeetable'
  end

end
