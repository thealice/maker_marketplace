class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_shop, except: [:index]
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
    if owner_of(@shop)
      render :edit
    else
      redirect_to shop_item_path(@shop, @item), alert: 'Only the shop owner can edit this item.'
    end
  end

  def update
  end

  def destroy
    if owner_of(@shop)
      @item.destroy
      redirect_to shop_path(@shop), notice: 'Item successfully deleted.'
    else
      redirect_to shop_item_path(@shop, @item), alert: 'Only the shop owner can delete this item.'
    end
  end

  private

    def set_item
      @item = Item.find_by_id(params[:id])
    end

    def set_shop
      @shop = Shop.find_by_id(params[:shop_id]) if Shop.find_by_id(params[:shop_id])
    end

    def item_params
      params.require(:item).permit(:id, :name, :description, :price, :quantity, :thumbnail, category_ids: [])
    end

end
