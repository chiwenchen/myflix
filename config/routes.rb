Myflix::Application.routes.draw do

  root to: 'videos#index'

  resources :categories, only: :show
  
  resources :videos, only: [:index, :show] do
    member do
      get :video 
    end
  end
  
  get '/home', to: 'videos#home'
  get ':controller(/:action)' # non-resourceful routes 




  #get 'videos/(:action)', controller: 'videos'
end
