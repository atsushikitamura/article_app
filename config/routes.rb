Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end
end
