class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def follow
    following_arr = current_user.followings.map { |x| x.id }
    @user = User.find_by_id(params[:id])
    type = params[:type]
    if type == "follow" && !following_arr.include?(@user.id)
      @user.followers << current_user
      redirect_to user_path(@user), notice: 'You followed ' + @user.name

    elsif type == "unfollow"
      current_user.followings.delete(@user)
      redirect_to user_path(@user), notice: 'Unfollowed ' + @user.name

    else
      # Type missing, nothing happens
      redirect_to user_path(@user), notice: 'Nothing happened.'
    end
  end

  def recipes
    @user = User.find_by_id(params[:user_id])
    @recipes = @user.recipes
  end

  def followings
    @user = User.find_by_id(params[:user_id])
    @follows = @user.followings
  end

  def reviews
    @user = User.find_by_id(params[:user_id])
    @reviews = @user.reviews
  end

  def favorites
    @user = User.find_by_id(params[:user_id])
    @recipes = @user.favorites
  end
end
