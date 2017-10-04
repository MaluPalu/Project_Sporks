class RecipesController < ApplicationController
  before_action :get_recipe, only: [:favorite, :show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_current_user, only: [:edit, :update, :destroy]

  def index

    search = params[:term].present? ? params[:term] : nil
    if search
      @recipes = Recipe.search(search, operator: "or", page: params[:page], per_page: 100)
    else
      @recipes = Recipe.all.page(params[:page]).per(100)
    end
  end

  def favorite

    type = params[:type]

    if type == "favorite" && !favorited_recipe?
      current_user.favorites << @recipe
      redirect_to recipe_path(@recipe), notice: 'You favorited ' + @recipe.title

    elsif type == "unfavorite" && favorited_recipe?
      current_user.favorites.delete(@recipe)
      redirect_to recipe_path(@recipe), notice: 'Unfavorited ' + @recipe.title

    else
      redirect_to recipe_path(@recipe), notice: 'Nothing happened.'
    end
  end

  def autocomplete
    render json: Recipe.search(params[:query], {
      fields: ["title", "ingredients"]
      }).map(&:title)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = Recipe.create(recipe_params)
    @user.recipes << @recipe
    redirect_to user_recipes_path(@recipe.user.id, @recipe.id)
  end

  def show
    @reviews = @recipe.reviews
    @user = User.find_by_id(@recipe.user_id)
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe.destroy
    redirect_to user_recipes_path(@recipe.user.id, @recipe.id)
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :prep_time, :cook_time, :ease, :ingredients, :instructions, :serves, :photo)
  end

  def get_recipe
    @recipe = Recipe.find_by_id(params[:id])
  end

  def check_current_user
    if current_user != User.find_by_id(@recipe.user_id)
      redirect_to root_path
    end
  end

end
