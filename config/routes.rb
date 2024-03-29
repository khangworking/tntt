Rails.application.routes.draw do
  devise_for :users
  namespace :api, format: :json do
    namespace :v0 do
      resources :gcatholics, only: :index
      resources :events, only: :index
      resources :students, only: %i[index show]
      resources :leaders, only: %i[index]
      resource :auth, only: :create, controller: 'auth'
      resource :basic_informations, only: :show
    end
  end

  namespace :admin do
    resource :dashboard, only: :show
    resource :calendars, only: :show
    resources :events
    resources :people do
      collection do
        post :export
        post :bulk_actions
        post :refreshes_feastyears
        put :bulk_update
      end
    end
    resource :profiles, only: %i[edit update]
    resources :levels, only: %i[index edit update]
    resources :categories, only: %i[index create edit update]
    resources :products, only: %i[index create new edit update]
    resources :product_requests, only: %i[index edit update]
    root to: 'dashboard#show'
  end

  scope '(:locale)', locale: /vi|en/ do

    namespace :managers do
      resource :dashboard, only: :show
      resources :events, only: :index
      resource :scores, only: :show do
        collection do
          post :create_presence_score
          delete :destroy_presence_score
        end
      end
      resources :level_scores, only: :destroy
      resources :levels, only: [] do
        scope module: :levels do
          resources :people_presences, only: %i[new create index]
          resources :scores, only: :index
        end
      end

      root to: 'dashboards#show'
    end

    resources :levels, only: %i[index show] do
      member do
        post :export
      end
      collection do
        get :bulk_show
      end
    end
    resources :people, only: %i[new create]
    resources :product_requests, only: %i[new create]
    resources :calendars, only: %i[index]

    get :glv, to: 'managers/dashboards#show'

    root to: 'home#index'
  end
end
