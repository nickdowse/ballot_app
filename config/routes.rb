Rails.application.routes.draw do



  resources :organisations do
    resources :allowed_emails
    resources :elections do
      resources :election_allowed_emails
      resources :candidates
      resources :votes
    end
  end

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
