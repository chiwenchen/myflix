Myflix::Application.routes.draw do

  root to: 'videos#front'

  resources :categories, only: :show

  get '/register', to: 'users#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  resources :users, only: [:create]

  
  resources :videos, only: [:index, :show] do
    collection do
      get :search;
      get :front
    end
    member do
      get :video 
    end
  end
  
  get '/home', to: 'videos#home'
  get ':controller(/:action)' # non-resourceful routes 




  #get 'videos/(:action)', controller: 'videos'
end
