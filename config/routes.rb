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
    end
    resources :candidates
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
