class HomepagesController < ApplicationController
  layout false, only: [:index]

  def index
  end

  def search
    allrecipes = Edamam_Api_Wrapper.search_recipes(params[:q])
    @your_recipes = allrecipes["hits"]
    @recipe_count = allrecipes["count"]
  end

  def show
    @recipe = Edamam_Api_Wrapper.get_recipe(params[:id])
  end
end
