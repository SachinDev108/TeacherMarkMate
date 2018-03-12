Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :teachers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :subjects do
    collection do
      get :fetch_children
    end 
  end
  resources :children
  resources :teachers do
    collection do
      post  :create_teacher
      get :teacher_subscription
    end
  end
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

  resources :subscriptions do
    collection do
      post :checkout
      get :thankyou
    end
  end
  get '*path' => redirect('/')
end
