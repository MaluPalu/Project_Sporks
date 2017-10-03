class RecipesController < ApplicationController

  def index
    search = params[:term].present? ? params[:term] : nil
    if search
      @recipes = Recipe.search(search, page: params[:page], per_page: 7)
    else
      @recipes = Recipe.all.page(params[:page]).per(7)
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
    # should go to profile recipes index
    redirect_to user_recipes_path({user_id: @recipe.user.id, recipe_id: @recipe.id})
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
    @reviews = @recipe.reviews
    @user = User.find_by_id(@recipe.user_id)
  end

  def edit
    @recipe = Recipe.find_by_id(params[:id])
  end

  def update
    recipe = Recipe.find_by_id(params[:id])
    recipe.update(recipe_params)
    redirect_to recipe_path(recipe)
  end

  def destroy
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    # should go to profile recipes index
    redirect_to user_recipes_path({user_id: @recipe.user.id, recipe_id: @recipe.id})
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :prep_time, :cook_time, :ease, :ingredients, :instructions, :serves, :photo)
  end

end
