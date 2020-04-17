class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_shop, except: [:index]
  before_action :check_permissions, except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]

  def show
    @categories = @item.categories if @item.categories
  end

  def index
    if params[:shop_id]
      @shop = Shop.find_by_id(params[:shop_id])
      @items = @shop.items
    else
      @items = Item.all
    end
  end

  def new
    @item = Item.new
  end

  def create
      @item = Item.new(item_params)
      @item.shop_id = params[:shop_id] if params[:shop_id]
      if @item.save
        redirect_to shop_item_path(@shop, @item), notice: 'Item was successfully created.'
      else
        render :new
      end
  end

  def edit
    render :edit
  end

  def update
    if @item.update(item_params)
      redirect_to shop_item_path(@shop, @item), notice: 'Item was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to shop_path(@shop), notice: 'Item successfully deleted.'
  end

  private

    def set_item
      if Item.find_by_id(params[:id])
        @item = Item.find_by_id(params[:id]) 
      else
        redirect_to root_path, alert: "Item not found"
      end
    end

    def set_shop
      @shop = Shop.find_by_id(params[:shop_id]) if Shop.find_by_id(params[:shop_id]) 
    end

    def item_params
      params.require(:item).permit(:id, :name, :description, :price, :quantity, :thumbnail, category_ids: [])
    end

    def check_permissions
      unless owner_of(@shop) || admin?
        redirect_to root_path, alert: "You are not authorized to complete this action."
      end
    end

end
