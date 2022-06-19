Rails.application.routes.draw do
  namespace :api, format: :json do
    namespace :v0 do
      resources :students, only: %i[index show]
      resources :leaders, only: %i[index]
      resource :auth, only: :create, controller: 'auth'
      resource :basic_informations, only: :show
    end
  end

  namespace :admin do
    resource :dashboard, only: :show
    resources :people, only: %i[index update]
    root to: 'dashboard#show'
  end

  if ENV['WEB_ACTIVE'] == '1'
    scope '(:locale)', locale: /vi|en/ do
      devise_for :users

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

      root to: 'home#index'
    end
  end
end
