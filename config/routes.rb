Rails.application.routes.draw do
  # For details on devise_for, see: https://www.rubydoc.info/github/plataformatec/devise/master/ActionDispatch/Routing/Mapper%3Adevise_for
  # Session routes for Authenticatable (default)
  # new_user_session GET    /users/sign_in                    {controller:"devise/sessions", action:"new"}
  # user_session POST   /users/sign_in                    {controller:"devise/sessions", action:"create"}
  # destroy_user_session DELETE /users/sign_out                   {controller:"devise/sessions", action:"destroy"}

# Password routes for Recoverable, if User model has :recoverable configured
  # new_user_password GET    /users/password/new(.:format)     {controller:"devise/passwords", action:"new"}
  # edit_user_password GET    /users/password/edit(.:format)    {controller:"devise/passwords", action:"edit"}
  # user_password PUT    /users/password(.:format)         {controller:"devise/passwords", action:"update"}
  #              POST   /users/password(.:format)         {controller:"devise/passwords", action:"create"}

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


