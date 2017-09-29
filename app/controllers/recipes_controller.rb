class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    @user = current_user
  end

  def new
    @recipe = Recipe.new
    @user = current_user
  end

  def create
    @user = current_user
    @recipe = Recipe.create(recipe_params)
    @user.recipes << @recipe
    redirect_to user_recipes_path
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
    @user = current_user
  end

  def edit
    @recipe = Recipe.find_by_id(params[:id])
    @user = current_user
  end

  def update
    recipe = Recipe.find_by_id(params[:id])
    recipe.update(recipe_params)
    redirect_to user_recipe_path({id: recipe.id})
  end

  def destroy
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    redirect_to user_recipes_path
  end


  private
  def recipe_params
    params.require(:recipe).permit(:title, :description, :prep_time, :cook_time, :ease, :ingredients, :instructions, :serves, :photo)
  end
end
