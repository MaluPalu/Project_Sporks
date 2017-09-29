class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = Recipe.create(recipe_params)
    @user.recipes << @recipe
    # should go to profile recipes index
    redirect_to root_path
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
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
    redirect_to root_path
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :prep_time, :cook_time, :ease, :ingredients, :instructions, :serves, :photo)
  end
  
end
