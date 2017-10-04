class ReviewsController < ApplicationController
  before_action :get_review, only: [:show, :edit, :update, :destroy]
  before_action :get_recipe, only: [:new, :create, :show, :edit]
  before_action :authenticate_user!, except: [:show]
  before_action :check_current_user, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    @recipe.reviews << @review
    current_user.reviews << @review
    redirect_to recipe_path(@recipe)
  end

  def show

  end

  def edit

  end

  def update
    @review.update(review_params)
    redirect_to recipe_review_path(params[:recipe_id], params[:id])
  end

  def destroy
    @review.destroy
    redirect_to user_reviews_path(@review.user_id)
  end

  private

  def review_params
    params.require(:review).permit(:image, :content, :rating, :title)
  end

  def get_review
    @review = Review.find_by_id(params[:id])
  end

  def get_recipe
    @recipe = Recipe.find_by_id(params[:recipe_id])
  end

  def check_current_user
    if current_user != User.find_by_id(@review.user_id)
      redirect_to root_path
    end
  end

end
