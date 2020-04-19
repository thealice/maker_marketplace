Rails.application.routes.draw do

  root to: 'items#index'
  get '/items', to: 'items#index'
  
  resources :shops do
    resources :items
  end
  resources :categories, only: [:show, :index]

  resources :conversations do
    resources :messages
  end
  
  devise_for :users,
    :controllers => { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" },
    :path_names => {
      :sign_in => 'login',
      :sign_out => 'logout',
      :registration => 'register',
      :sign_up => 'signup' 
    }
  # For details on devise_for, see: https://www.rubydoc.info/github/plataformatec/devise/master/ActionDispatch/Routing/Mapper%3Adevise_for

end


