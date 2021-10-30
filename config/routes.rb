Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    devise_for :users
    resources :people, only: %i[new create]
    root to: 'home#index'

    namespace :admin do
      resource :dashboard, only: :show

      root to: 'dashboards#show'
    end
  end
end
