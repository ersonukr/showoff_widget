Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "widgets#index"
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create] do
    collection do
      get :reset_password
      post :reset_password
      get  :widgets
    end
  end
  resources :widgets, only: [:index, :new, :create]
end
