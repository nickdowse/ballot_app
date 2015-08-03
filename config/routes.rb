Rails.application.routes.draw do



  resources :organisations do
    member do
      get :users
      post :make_admin
      post :make_user
      post :remove_user
      get :org_candidates
    end
    resources :allowed_emails
    resources :elections do
      resources :election_allowed_emails
      resources :candidates do
        collection do
          get :bulk_add
          post :add_candidates_to_election
        end
        member do
          post :remove_candidate
        end
      end
      resources :votes
      member do
        get :results
      end
    end
  end

  root to: 'visitors#index'
  devise_for :users
  devise_scope :user do
    match '/sign-in' => "devise/sessions#new", :as => :login, via: [:get]
  end
  resources :users do
    member do
      patch :change_role
    end
  end
end
