Rails.application.routes.draw do

  resources :users do
    resources :outreach_reports
  end

  resources :teams
  get 'login' => 'sessions#new', as: 'login'
  post 'login' => 'sessions#create'
  get 'register' => 'users#new', as: 'register'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  root 'site#landing'
end
