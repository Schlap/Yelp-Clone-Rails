class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
  @review.user = current_user
  if @review.save
    flash[:notice] = "Thank you for your review"
    redirect_to restaurants_path
  else @review.delete
    flash[:notice] = "Sorry, you have already reviewed this restaurant"
    redirect_to restaurants_path
  end
end

  # def destroy
  #   @review = Review.find(params[:id])
  #   @review.destroy
  #   flash[:notice] = "Review was deleted"
  #   redirect_to restaurants_path
  # end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end