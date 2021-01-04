Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'sessions', registrations: 'registrations' }
  root to: 'welcome#index'
  match 'examination(/*path)', to: 'static#index', via: :all
  namespace :admin do
    resources :dashboard, only: :index
    resources :users, only: [:index, :edit, :update]
    resources :candidates
    resources :examinations
    resources :licenses, only: [:new, :create, :update, :destroy] do
      put :undiscard, on: :member
    end
    resources :exams do
      member do
        get :assign
        get 'bulk_assign' => 'exams#bulk_assign'
        post 'bulk_assign' => 'exams#bulk_assign_post'
      end
    end
    resources :clients do
      get :examinations
      get :licenses
      member do
        get :candidates
        post :add_candidate
        post :add_user
        post :add_licence
      end
    end
    resources :tasks do
      resources :items, only: %i[index create destroy update] do
        member do
          patch :move_up
          patch :move_down
        end
      end
      member do
        get :settings
        patch :update_settings
        patch :toggle_published
      end
    end
    resources :items, only: [] do
      resources :options, only: %i[create update destroy] do
        patch :toggle_correct, on: :member
      end
    end
  end
end



