class ApplicationController < ActionController::Base
    # see https://nvisium.com/blog/2014/09/10/understanding-protectfromforgery.html
    protect_from_forgery with: :exception
    helper_method :owner_of, :item_owner, :admin?

    def owner_of(shop)
        user_signed_in? && shop.user_id == current_user.id
    end

    def item_owner(item)
        user_signed_in? && item.shop.user_id == current_user.id
    end
    
    def admin?
        user_signed_in? && current_user.admin?
    end

end
