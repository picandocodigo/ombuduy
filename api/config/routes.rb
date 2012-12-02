Api::Application.routes.draw do

  get "home/index"

  match '/auth/:provider/callback' => 'authentications#create'
  
  devise_for :users, :controllers => {:registrations => 'registrations'}

  post 'twitter/new' => 'twitter#new'
  post 'twitter/reply' => 'twitter#reply'
  post 'twitter/rt' => 'twitter#rt'
  
  resources :authentications

  resources :issues do
    member do
      get 'fix'
      get 'unfix'
    end
  end
  resources :tags

  root :to => 'home#index'

end
