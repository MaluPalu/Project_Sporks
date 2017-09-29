class UsersController < ApplicationController

  def index
  end

  def show
    @user = current_user
  end

  def recipes
    @user = User.find_by_id(params[:user_id])
    @recipes = @user.recipes
  end

  def reviews
    @user = User.find_by_id(params[:user_id])
    @reviews = @user.reviews
  end
end
