SportsScraper::Application.routes.draw do
  root to: 'search#index'

  get 'search' => 'search#index'
  post 'search' => 'search#new'
end
