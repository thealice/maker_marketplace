class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def show
  end

  def index
    if params[:shop_id]
      @items = Shop.find(params[:shop_id]).items
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
      redirect_to item_path(@item), notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def edit
    if params[:shop_id]
      @shop = Shop.find(params[:shop_id])
      if owner_of(@shop)
        render :edit
      else
        redirect_to shop_item_path(params[:shop_id], @item.id), alert: 'Only the shop owner can edit this item.'
      end
    end
  end

  def update
  end

  def destroy
    if params[:shop_id]
      @shop = Shop.find(params[:shop_id])
      if owner_of(@shop)
        @item.destroy
        redirect_to items_path, notice: 'Item successfully deleted.'
      else
        redirect_to shop_item_path(params[:shop_id], @item.id), alert: 'Only the shop owner can delete this item.'
      end
    end
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:id, :name, :description, :price, :quantity, :thumbnail, :category_ids [])
    end

end
