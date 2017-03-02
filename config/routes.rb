Rails.application.routes.draw do
  devise_for :users

  root 'projects#index'

  namespace :api do
    resources :projects do
      resources :tasks do
        patch :reorder, on: :member
      end
    end
  end
end
