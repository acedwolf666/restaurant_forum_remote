class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.page(params[:page]).per(12)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  def favorite
    @restaurant = Restaurant.find(params[:id])
    Favorite.create!(restaurant: @restaurant, user: current_user)
    #@restaurant.count_favorites  (replaced by counter_cache)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorite = Favorite.where(restaurant: @restaurant, user: current_user)
    favorite.destroy_all
    #@restaurant.count_favorites
    redirect_back(fallback_location:root_path)
  end

  def ranking
    @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

  def like
    @restaurant = Restaurant.find(params[:id])
    Like.create!(restaurant: @restaurant, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def dislike
    @restaurant = Restaurant.find(params[:id])
    like = Like.where(restaurant: @restaurant, user: current_user)
    like.destroy_all
    redirect_back(fallback_location:root_path)
  end

  def about
    @user_count = User.get_user_count
  end
end
