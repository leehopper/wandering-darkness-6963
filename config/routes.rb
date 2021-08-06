Rails.application.routes.draw do
  resources :plots, only: :index

  resources :plot_plants, only: :destroy

  resources :gardens, only: :show
end
