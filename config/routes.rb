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
      get :report
      get :report_details
    end 
    member do
      get :child_detail
      patch :update_detail
    end
  end
  get '*path' => redirect('/')
end
