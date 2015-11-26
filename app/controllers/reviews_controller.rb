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
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        # Note: if you have correctly disabled the review button where appropriate,
        # this should never happen...
        redirect_to restaurants_path, alert: 'Restaurant already reviewed'
      else
        # Why would we render new again?  What else could cause an error?
        render :new
      end
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user_id != current_user.id
      flash[:notice] = 'Review cannot be deleted'
      redirect_to root_path
    else
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
      redirect_to '/restaurants'
    end
  end

end
