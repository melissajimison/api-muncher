require 'EdamamApiWrapper'

class HomepagesController < ApplicationController
  layout false, only: [:index]
  helper_method :maxpage

  def index
  end

  def search
    @page = (params[:page] || 1).to_i
    @query = params[:q]

    allrecipes = EdamamApiWrapper.search_recipes(@query, @page)
    @your_recipes = allrecipes["hits"]
    @recipe_count = allrecipes["count"]

    if @your_recipes.empty? || @recipe_count == 0
      flash[:notice] = "No result"
    end
  end

  def show
    @recipe = EdamamApiWrapper.get_recipe(params[:id])
  end

  def maxpage
    return @recipe_count/10
  end

end
