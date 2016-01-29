Rails.application.routes.draw do

  resources :users, except: [:destroy] do
    resources :outreach_reports, only: [:new, :create]
  end

  scope module: 'internal' do
    resources :teams, only: [:new, :create, :edit, :update, :delete] do
      resources :memberships, only: [:create, :destroy]
    end
    get '/dashboard' => 'dashboard#index', as: 'internal_root'
  end

  scope :rankings do
    get '/' => 'rankings#index', as: 'rankings'
    get '/users' => 'rankings#user', as: 'user_rankings'
    get '/teams' => 'rankings#teams', as: 'team_rankings'
  end
  resources :teams, only: [:index, :show]
  get 'login' => 'sessions#new', as: 'login'
  post 'login' => 'sessions#create'
  get 'register' => 'users#new', as: 'register'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  root 'site#landing'
end
