class EmpSessionsController < ApplicationController
  def new
    
  end

  def create
    employee = Employee.find_by(username: params[:session][:username])
    if employee && employee.authenticate(params[:session][:password])
      log_in employee
      flash[:success] = 'Success'
      redirect_to employeeportal_dashboard_path  
    else
      flash.now[:danger] = 'Invalid username/password combination' 
      render 'new'
    end
  end

  def show
    
  end

  def destroy
    log_out
    redirect_to root_url
  end

end