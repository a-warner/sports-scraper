SportsScraper::Application.routes.draw do
  root to: 'search#index'

  get 'search' => 'search#index'
  post 'search' => 'search#new'

  resources :players, only: [:show]
  resources :teams, only: [:show] do
    resources :player_depths, only: [:index]
  end
end
