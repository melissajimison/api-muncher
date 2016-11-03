class HomepagesController < ApplicationController
  layout false, only: [:index]
  helper_method :maxpage

  def index
  end

  def search
    @page = (params[:page] || 1).to_i
    @query = params[:q]

    allrecipes = Edamam_Api_Wrapper.search_recipes(@query, @page)
    @your_recipes = allrecipes["hits"]
    @recipe_count = allrecipes["count"]
  end

  def show
    @recipe = Edamam_Api_Wrapper.get_recipe(params[:id])
  end

  def maxpage
    return @recipe_count/10
  end

end
