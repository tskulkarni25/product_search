Rails.application.routes.draw do
  root to: "products#index"
  
  resources :products do
    collection do
      post :search
    end
  end
end
