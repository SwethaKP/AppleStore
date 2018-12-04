Rails.application.routes.draw do
  devise_for :users, :path_names => { :sign_up => "register" }
  
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'   
    end

  get 'welcome/index'
  resources :orders
  
  authenticated :user do 
    root 'orders#index', as: "authenticated_root"
  end

  root 'welcome#index'
end
