class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_id(params[:id])
    @items = @category.items.all
  end
end
