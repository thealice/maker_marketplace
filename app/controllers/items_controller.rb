class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def show
  end

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
