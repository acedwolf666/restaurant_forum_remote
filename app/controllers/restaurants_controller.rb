class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.page(params[:page]).per(12)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end
end
