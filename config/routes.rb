require 'sidekiq/web'

Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Root path
  root to: "items#index"

  # Sidekiq Web UI at /sidekiq
  mount Sidekiq::Web => "/sidekiq"

  # Items CRUD with custom member and collection routes
  resources :items do
    member do
      patch :soft_delete   # /items/:id/soft_delete
      patch :restore       # /items/:id/restore
    end

    collection do
      get :trashed         # /items/trashed
    end
  end
end
