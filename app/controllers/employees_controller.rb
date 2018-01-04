class EmployeesController < ApplicationController
  before_action :logged_in_employee, only: [:edit]
  before_action :logged_in_admin, only: [:admindashboard, :employeedetails, :addemployee, :employeetable, :projects]

  def new
    redirect_to employeeportal_login_path
  end

  def edit
    @employee = current_employee
  end

  def update
    @employee = Employee.find(params[:id])
      if @employee.update_attributes(employee_params) 
        flash[:success] = "Profile updated"     
        redirect_to employeeportal_dashboard_path
      else 
        render 'edit'
      end
  end

  def adminlogin

  end

  def admindashboard

  end

  def employeedetails

  end

  def addemployee

  end

  def employeetable
    @employee = Employee.all
  end

  def projects

  end

  private

  def employee_params
    params.require(:employee).permit( :phone, :personal_email, :address)
  end

end
