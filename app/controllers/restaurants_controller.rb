class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @user = User.find(current_user)
    @restaurant = @user.restaurants.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
        redirect_to restaurants_path
    else
        render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = current_user.restaurants.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "You cannot edit this restaurant - Unlucky!"
    redirect_to '/restaurants'
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update.(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = current_user.restaurants.find(params[:id])
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :image)
  end
end