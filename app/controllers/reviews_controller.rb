class ReviewsController < ApplicationController

  def new
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @review = Review.new
  end

  def create
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @review = Review.create(review_params)
    @recipe.reviews << @review
    current_user.reviews << @review
    redirect_to recipe_path(@recipe)
  end

  def show
    @review = Review.find_by_id(params[:id])
    @recipe = Recipe.find_by_id(params[:recipe_id])
  end

  def edit
    @review = Review.find_by_id(params[:id])
    @recipe = Recipe.find_by_id(params[:recipe_id])
  end

  def update
    review = Review.find_by_id(params[:id])
    review.update(review_params)
    redirect_to recipe_review_path(params[:recipe_id], params[:id])
  end

  def destroy
    @review = Review.find_by_id(params[:id])
    @review.destroy
    redirect_to user_reviews_path(@review.user_id, @review.id)
  end

  private

  def review_params
    params.require(:review).permit(:image, :content, :rating, :title)
  end
end
