Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'
  
  resources :questions do
    resources :comments, except: [:index], module: :questions
    resources :votes, only: [:create, :destroy], module: :questions

    resources :answers, except: [:index] do
      #resources :votes, only: [:create, :destroy]
      resources :comments, except: [:index], module: :answers
    end

  end

  # concern :votable do
  #   put    'vote' => :vote,   on: :member
  #   delete 'unvote' => :unvote, on: :member
  # end

  # resources :questions, only: [:index, :new, :create, :show], concerns: :votable do
  #   resources :comments, module: :questions

  #   resources :answers, only: [:create], concerns: :votable do
  #     resources :comments, module: :answers
  #   end
  # end
 
end