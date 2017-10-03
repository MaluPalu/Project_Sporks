class RecipesController < ApplicationController
  before_action :get_recipe, only: [:favorite, :show, :edit, :udpate, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    search = params[:term].present? ? params[:term] : nil
    if search
      @recipes = Recipe.search(search, page: params[:page], per_page: 7)
    else
      @recipes = Recipe.all.page(params[:page]).per(7)
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
    redirect_to user_recipes_path({user_id: @recipe.user.id, recipe_id: @recipe.id})
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
    # should go to profile recipes index
    redirect_to user_recipes_path(@recipe.user.id, @recipe.id)
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :prep_time, :cook_time, :ease, :ingredients, :instructions, :serves, :photo)
  end

  def get_recipe
    @recipe = Recipe.find_by_id(params[:id])
  end

end
