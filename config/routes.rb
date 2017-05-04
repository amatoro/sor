Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  
  resources :questions do
    resources :comments, module: :questions

    resources :answers, only: [:new, :create, :destroy, :edit, :update] do
       resources :comments, module: :answers
    end

  end
 
end