Rails.application.routes.draw do
  scope "(:locale)", locale: /vi|en/ do
    devise_for :users
    # resources :people, only: %i[new create]
    root to: 'home#index'

    namespace :managers do
      resource :dashboard, only: :show
      resources :people, only: %i[index show edit update create new]
      resources :people_presences, only: %i[new create edit update]
      resources :scores, only: %i[show]

      resources :levels, only: [] do
        scope module: :levels do
          resources :people_presences, only: :index
        end
      end

      root to: 'dashboards#show'
    end

    namespace :admin do
      resource :dashboard, only: :show
      resources :people, only: [] do
        collection do
          post :export
        end
      end

      root to: 'dashboard#show'
    end
  end
end
