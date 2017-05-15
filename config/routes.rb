Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  
  resources :questions do
    resources :comments, except: [:index], module: :questions
    resources :votes, only: [:create, :destroy], module: :questions

    resources :answers, except: [:index] do
      resources :comments, except: [:index], module: :answers
      resources :votes, only: [:create, :destroy], module: :answers
    end

  end
 
end