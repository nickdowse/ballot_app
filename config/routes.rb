Rails.application.routes.draw do
  resources :organisations do
    resources :allowed_emails
  end

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
