Api::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#create'
  
  devise_for :users, :controllers => {:registrations => 'registrations'}

  post 'twitter/new' => 'twitter#new'
  post 'twitter/reply' => 'twitter#reply'
  post 'twitter/rt' => 'twitter#rt'
  
  resources :authentications
  resources :issues
  resources :tags
end
