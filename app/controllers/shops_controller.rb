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
        if owner_of(@shop)
          render :edit
        else
          redirect_to root_path, alert: 'You are not authorized to edit that shop.'
        end
      end

      def update
        if owner_of(@shop)
          if @shop.update(shop_params)
            redirect_to shop_path(@shop), notice: 'Shop was successfully updated.' 
          else
            render :edit
          end
        else
          redirect_to root_path, alert: 'You are not authorized to edit that shop.'
        end
      end

      def destroy
        if owner_of(@shop)
          @shop.destroy
          redirect_to shops_path, notice: 'Shop was successfully deleted.'
        else
          redirect_to root_path, alert: 'You are not authorized to delete that shop.'
        end
      end

      private

      def set_shop
        if Shop.find_by_id(params[:id])
          @shop = Shop.find_by_id(params[:id])
        else
          redirect_to shops_path, alert: "Shop not found."
        end
      end
  
      def shop_params
        params.require(:shop).permit(:name, :status, :user_id, :featured_image, :description, items_attributes: [:id, :name, :description, :price, :quantity, :thumbnail, category_ids: []])
      end
end
