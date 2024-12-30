Rails.application.routes.draw do
  get "dashboards/index", as: :dashboards
  resources :logins, only: %i[new create]
  resources :registrations, only: %i[new create]
  resources :posts, only: %i[index show new create edit update]

  # root "articles#index"
end
