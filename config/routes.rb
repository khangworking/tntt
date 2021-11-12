Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    devise_for :users
    resources :people, only: %i[new create]
    root to: 'home#index'

    namespace :managers do
      resource :dashboard, only: :show
      resources :people, only: %i[index show]

      root to: 'dashboards#show'
    end
  end
end
