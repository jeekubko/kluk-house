Rails.application.routes.draw do
  resources :exercise_plan_items
  resources :exercise_plans
  resources :exercises
  get 'pages/index'
  get 'pages/test'
  get 'profile', to: 'users#show'
  devise_for :users

  devise_scope :user do
    get 'profile/edit', to: 'devise/registrations#edit', as: :edit_profile
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', :as => :rails_health_check

  # Defines the root path route ("/")
  root 'pages#index'
end
