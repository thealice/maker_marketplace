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

      def edit
      end

      def update
        if @shop.update(shop_params)
          redirect_to shop_path(@shop), notice: 'Shop was successfully updated.' 
        else
          render :edit
        end
      end

      def destroy
        @shop.destroy
        redirect_to shops_path, notice: 'Shop was successfully deleted.'
      end

      private

      def set_shop
        @shop = Shop.find(params[:id])
      end
  
      def shop_params
        params.require(:shop).permit(:name, :status, :user_id, :featured_image, :description, items_attributes: [:id, :name, :description, :price, :quantity, :thumbnail, :category_ids []])
    end
end
