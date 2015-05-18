Rails.application.routes.draw do

  resources :elections do
    resources :election_allowed_emails
  end

  resources :organisations do
    resources :allowed_emails
  end

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
