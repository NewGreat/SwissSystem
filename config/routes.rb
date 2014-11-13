Rails.application.routes.draw do
  resources :tournaments, except: :destroy do 
    member do
      get :start
    end
  end
  resources :rounds, only: :show
  resources :challanges, only: :update
  resources :players, only: :index
  root to: 'tournaments#index'
end
