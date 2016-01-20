Myflix::Application.routes.draw do
  root to: 'videos#front'

  resources :categories, only: :show

  get '/register', to: 'users#new'
  get '/register_with_token', to: 'users#new_with_invitation'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  get 'forget_password', to: 'forget_password#new'
  get 'confirm_reset_password', to: 'forget_password#confirm' 
  get 'reset_password_page', to: 'forget_password#reset_password_page'
  post 'reset_password', to: 'forget_password#reset_password'
  resources :forget_password, only: [:create]
  resources :users, only: [:create, :show]
  resources :relationships, only: [:create, :destroy]
  resources :invitations, only:[:new, :create]
  
  namespace :admin do
    resources :videos, only: [:new, :create] 
  end

  resources :queue_items, only: [:index, :create, :destroy] do 
    collection do 
      post :update_position;
    end
  end

  get :people, to: 'relationships#index'
 
  resources :videos, only: [:index, :show] do
    collection do 
      get :search;
      get :front;
    end
    resources :reviews, only: [:create]
  end
  
  get '/home', to: 'videos#home'
  get ':controller(/:action)' # non-resourceful routes 

  mount StripeEvent::Engine, at: '/stripe_events'
  #get 'videos/(:action)', controller: 'videos'
end
