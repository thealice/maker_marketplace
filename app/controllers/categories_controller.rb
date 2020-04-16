class CategoriesController < ApplicationController
  before_action :set_category
  
  def show
    @items = @category.items.all
  end

  def index
    @categories = Category.all.sort
  end

  private

  def set_category
    @category = Category.find_by_id(params[:id]) if Category.find_by_id(params[:id])
  end

end
