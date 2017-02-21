Rails.application.routes.draw do
  devise_for :users
  # root to: "home#index"
  root to: "questions#index"

  resources :questions do
    resources :answers
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
