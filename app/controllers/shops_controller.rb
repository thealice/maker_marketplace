class ShopsController < ApplicationController
    before_action :set_shop, only: [:show, :edit, :update, :destroy]
    #authenticate_user! is a devise method
    before_action :authenticate_user!, except: [:index, :show] 
    
    def index
        # TODO: update so only active shops are displayed here
        @shops = Shop.all
      end
    
      def show
        @owner = @shop.user
      end
    
      def new
        @shop = Shop.new
      end
    
      def create
        @shop = Shop.new(shop_params)
        @shop.user_id = current_user.id
          if @shop.save
            redirect_to shop_path(@shop), notice: 'Shop was successfully created.'
          else
            render :new
          end
      end

      private

      def set_shop
        @shop = Shop.find(params[:id])
      end
  
      def shop_params
        params.require(:shop).permit(:name, :status, :user_id)
    end
end
