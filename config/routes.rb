Rails.application.routes.draw do
  root "items#index"

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
