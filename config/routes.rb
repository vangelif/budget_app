Rails.application.routes.draw do 
  get 'expenses/index'
  get 'expenses/new'
  
  devise_for :users

  root 'splash#index'
  # get "categories", to: "categories#index"
  resources :categories, only: [:index, :new, :show, :create, :sign_out, :destroy] do
    delete :destroy, on: :member
  end
  resources :expenses, only: [:index, :new, :create, :destroy]
  # delete 'categories/sign_out', to: 'categories#sign_out', as: :sign_out_categories


  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
