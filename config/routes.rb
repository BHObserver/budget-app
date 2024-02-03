Rails.application.routes.draw do
  devise_for :users

  # Spalsh screen
  authenticated :user do
    root "expenses#index", as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root "splash_screen#index", as: :unauthenticated_root
    end
  end

  # Rails restful routes
  resources :expenses, except: [:edit, :update, :destroy] do
    resources :payments, except: [:edit, :update, :destroy]
  end
end
