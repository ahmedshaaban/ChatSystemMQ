Rails.application.routes.draw do 
  resources :applications do
    resources :chats, only: [:index, :create]  do
      resources :messages, only: [:index, :create]
    end 
  end
  resources :chats, only: [:show, :update]  
  resources :messages, only: [:show, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
