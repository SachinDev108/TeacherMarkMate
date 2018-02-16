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
      get :child_detail
      post :update_detail
    end
  end
end
