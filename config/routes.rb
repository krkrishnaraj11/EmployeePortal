Rails.application.routes.draw do
  get '/employeeportal/login', to: 'emp_sessions#new'
  post '/employeeportal/login', to: 'emp_sessions#create'
  delete '/employeeportal/logout', to: 'emp_sessions#destroy'

  get '/employeeportal/dashboard', to: 'emp_sessions#show'

  root 'employees#new'
  resources :employees
end
