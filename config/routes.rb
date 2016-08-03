Rails.application.routes.draw do
  resources  :cats, only:[:index, :show, :new, :edit, :update, :create]
  root to: 'cats#index'
  resources :cat_rental_requests, only:[:new,:create]
  post "/cat_rental_requests/:id/approve", to: "cat_rental_requests#approve!", as: "approve"
end
