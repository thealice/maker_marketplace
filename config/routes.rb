Rails.application.routes.draw do
  get 'categories/show'
  root to: 'shops#index'
  
  resources :shops
  resources :categories, only: [:show]
  
  devise_for :users,
    :controllers => { registrations: 'users/registrations'},
    :path_names => {
      :sign_in => 'login',
      :sign_out => 'logout',
      :registration => 'register',
      :sign_up => 'signup' 
    }
  # For details on devise_for, see: https://www.rubydoc.info/github/plataformatec/devise/master/ActionDispatch/Routing/Mapper%3Adevise_for

end


