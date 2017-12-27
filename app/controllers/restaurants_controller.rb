class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.page(params[:page]).per(12)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
