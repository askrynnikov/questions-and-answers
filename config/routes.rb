# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :questions do
    resources :answers, only: [:create, :update, :destroy], shallow: true do
      patch 'mark_best', on: :member
    end
  end

  # resources :answers, only: [:update, :destroy] do
  #   patch 'mark_best', on: :member
  # end
end
