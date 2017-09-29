class RecipesController < ApplicationController

  def index

  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    redirect_to user_recipe_path(@recipe)
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
  end


  private
  def recipe_params
    params.require(:recipe).permit(:title, :description, :prep_time, :cook_time, :ease, :ingredients, :instructions, :serves, :photo)
  end
end
