class ApplicationController < ActionController::Base
    # see https://nvisium.com/blog/2014/09/10/understanding-protectfromforgery.html
    protect_from_forgery with: :exception
    helper_method :owner_of, :admin?

    def owner_of(resource)
        user_signed_in? && resource.user_id == current_user.id
    end
    
    def admin?
        user_signed_in? && current_user.admin?
    end

end
