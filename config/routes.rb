Myflix::Application.routes.draw do

  root to: 'videos#front'

  resources :categories, only: :show

  get '/register', to: 'users#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  resources :users, only: [:create]
  resources :queue_items, only: [:index, :create, :destroy]
 
  resources :videos, only: [:index, :show] do
    collection do 
      get :search;
      get :front;
    end
    resources :reviews, only: [:create]
  end
  
  get '/home', to: 'videos#home'
  get ':controller(/:action)' # non-resourceful routes 

  #get 'videos/(:action)', controller: 'videos'
end
