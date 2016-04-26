Rails.application.routes.draw do
  resources :organisations do
    member do
      get :users
      post :make_admin
      post :make_user
      post :remove_user
    end
    resources :elections do
      resources :votes
      member do
        get :results
      end
      collection do
        get :show_election_history
      end
    end

    resources :candidates
  end

  root to: 'visitors#index'
  resources :users do
    member do
      patch :change_role
    end
  end
end
