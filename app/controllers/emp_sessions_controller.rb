class EmpSessionsController < ApplicationController

  before_action :logged_in_employee, only: [:show]
  def new
    
  end

  def create
    employee = Employee.find_by(username: params[:session][:username])
    if employee && employee.authenticate(params[:session][:password])
      log_in employee
      params[:session][:remember_me] == '1' ? remember(employee) : forget(employee)
      if !employee.admin && request.original_fullpath == employeeportal_login_path
        flash[:success] = 'Login Successful'
        redirect_to employeeportal_dashboard_path
      elsif employee.admin && request.original_fullpath == admin_login_path
        flash[:success] = 'Login Successful'
        redirect_to admin_dashboard_path 
      else 
        flash[:danger] = "Invalid username/password combination"
        redirect_back(fallback_location: request.original_fullpath)
      end
    else 
      flash[:danger] = "Invalid username/password combination"
      redirect_back(fallback_location: request.original_fullpath)
    end
  end

  def show
    @employee = current_employee 
  end

  def destroy
    log_out if logged_in?
    redirect_to employeeportal_login_path
  end

  def login
    @employee = Employee.koala(request.env['omniauth.auth']['credentials'])
  end
end