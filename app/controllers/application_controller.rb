class ApplicationController < ActionController::Base
    # see https://nvisium.com/blog/2014/09/10/understanding-protectfromforgery.html
    protect_from_forgery with: :exception


end
