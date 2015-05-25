Rails.application.routes.draw do



  resources :organisations do
    member do
      get :users
      post :make_admin
      post :make_user
      post :remove_user
    end
    resources :allowed_emails
    resources :elections do
      resources :election_allowed_emails
      resources :candidates
      resources :votes
    end
  end

  root to: 'visitors#index'
  devise_for :users
  devise_scope :user do
    match '/sign-in' => "devise/sessions#new", :as => :login, via: [:get]
  end
  resources :users
end
