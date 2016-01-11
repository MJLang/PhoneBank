Rails.application.routes.draw do

  resources :users, except: [:destroy] do
    resources :outreach_reports, except: [:destroy]
  end

  scope module: 'internal' do
    resources :teams, only: [:new, :create, :edit, :update, :delete] do
      resources :memberships, only: [:create, :destroy]
    end

    get '/dashboard' => 'dashboard#index', as: 'internal_root'
  end

  resources :teams, only: [:index, :show]
  get 'login' => 'sessions#new', as: 'login'
  post 'login' => 'sessions#create'
  get 'register' => 'users#new', as: 'register'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  root 'site#landing'
end
