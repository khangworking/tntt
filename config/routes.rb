Rails.application.routes.draw do
  resources :people, only: %i[new create]

  root to: 'home#index'
end
