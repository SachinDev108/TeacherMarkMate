Rails.application.routes.draw do
  devise_for :teachers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :subjects do
    collection do
      get :fetch_children
    end 
  end
  resources :children
  resources :sheets do
    collection do
      get :fetch_children
    end 
    member do
      get :add_child
      post :create_child
    end
  end
end
