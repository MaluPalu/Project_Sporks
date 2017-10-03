class UsersController < ApplicationController
  before_action :get_user, except: [:index]

  def index
  end

  def show
  end

  def follow

    type = params[:type]
    if type == "follow" && !following_user?
      @user.followers << current_user
      redirect_to user_path(@user), notice: 'You followed ' + @user.name

    elsif type == "unfollow" && following_user?
      current_user.followings.delete(@user)
      redirect_to user_path(@user), notice: 'Unfollowed ' + @user.name

    else
      # Type missing, nothing happens
      redirect_to user_path(@user), notice: 'Nothing happened.'
    end
  end

  def recipes
    @recipes = @user.recipes
  end

  def followings
    @follows = @user.followings
  end

  def reviews
    @reviews = @user.reviews
  end

  def favorites
    @recipes = @user.favorites
  end

  private

  def get_user
    @user = User.find_by_id(params[:id])
  end


end
