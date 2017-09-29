class ReviewsController < ApplicationController

  def new
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    redirect_to 
  end

  private

  def review_params
    params.require(:review).permit(:image, :content, :rating)
  end
end
