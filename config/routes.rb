Rails.application.routes.draw do
  get '/employeeportal/login', to: 'emp_sessions#new'
  post '/employeeportal/login', to: 'emp_sessions#create'
  delete '/employeeportal/logout', to: 'emp_sessions#destroy'

  get '/employeeportal/dashboard', to: 'emp_sessions#show'

  get '/employeeportal', to: 'employees#edit'
  patch '/employeeportal', to: 'employees#update'

  get '/admin/login', to: 'employees#adminlogin'
  post '/admin/login', to: 'emp_sessions#create'
  delete '/admin/logout', to: 'emp_sessions#destroy'

  get '/admin/dashboard', to: 'employees#admindashboard'
  get '/admin/employee', to: 'employees#employeetable'
  get '/admin/addemployee', to: 'employees#addemployee'
  get '/admin/employeedetails', to: 'employees#employeedetails'
  get '/admin/projects', to: 'employees#projects'

  root 'employees#new'
end
