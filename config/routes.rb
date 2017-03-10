# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  concern :votable do
    resources :votes, only: [:create, :destroy]
  end

  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable, only: [:create, :update, :destroy], shallow: true do
      patch 'mark_best', on: :member
    end
  end

  resources :attachments, only: [:destroy]
end
