module EmpSessionsHelper
    # Logs in the given employee.
    def log_in(employee)
        session[:employee_id] = employee.id
    end

    # Returns the current logged-in employee (if any).
    def current_employee
        @current_employee ||= Employee.find_by(id: session[:employee_id])
    end

    # Returns true if the employee is logged in, false otherwise.
    def logged_in?
        !current_employee.nil?
    end

    # Logs out the current employee.
    def log_out
        session.delete(:employee_id)
        @current_employee = nil
    end
end