Api::Application.routes.draw do

  post 'twitter/new' => 'twitter#new'
  post 'twitter/reply' => 'twitter#reply'
  post 'twitter/rt' => 'twitter#rt'

  resources :issues
end
