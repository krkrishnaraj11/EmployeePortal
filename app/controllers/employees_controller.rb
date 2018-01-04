class EmployeesController < ApplicationController
  def new
    redirect_to employeeportal_login_path
  end
end
