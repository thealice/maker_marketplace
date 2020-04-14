Rails.application.routes.draw do

  root to: 'shops#index'
  
  resources :shops do
    resources :items
  end
  resources :categories, only: [:show, :index]
  
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


