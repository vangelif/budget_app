Rails.application.routes.draw do 
  
  devise_for :users

  root 'splash#index'

  resources :categories, only: [:index, :new, :show, :create, :sign_out, :destroy] do
    delete :destroy, on: :member
  end
  resources :expenses, only: [:index, :new, :create, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check

end