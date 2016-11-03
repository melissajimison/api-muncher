require 'httparty'


class Edamam_Api_Wrapper
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]
  BASE_URL = "https://api.edamam.com/search?"

  def self.search_recipes(keyword, page)
    from = (page-1)*10

    to = page*10

    url = BASE_URL + "app_id=#{APP_ID}" + "&app_key=#{APP_KEY}" + "&q=#{keyword}" + "&from=#{from}" + "&to=#{to}"

    response = HTTParty.get(url)

    return_recipes = {}
    # This hash contains the total number of returned hits or count
    return_recipes["count"] = response["count"]
    return_recipes["hits"] = []

    response["hits"].each do |rec|
      label = rec["recipe"]["label"]
      image = rec["recipe"]["image"]
      ingredients = rec["recipe"]["ingredients"]
      uri = rec["recipe"]["uri"]

      return_recipes["hits"] << Recipe.new(label, image, ingredients, uri)
    end

    return return_recipes
  end


  def self.get_recipe(uri)

    if uri == nil
      flash[:notice] = "Recipe not found"
      redirect_to root_path
    end

    url = BASE_URL + "app_id=#{APP_ID}" + "&app_key=#{APP_KEY}" + "&r=http://www.edamam.com/ontologies/edamam.owl%23recipe_#{uri}"

    response = HTTParty.get(url)

    label = response[0]["label"]
    image = response[0]["image"]
    ingredients = response[0]["ingredients"]
    uri = response[0]["uri"]
    url = response[0]["url"]
    servings = response[0]["yield"]
    calories = response[0]["calories"]
    healthLabels = response[0]["healthLabels"]
    digest = response[0]["digest"]

    recipe = Recipe.new(label, image, ingredients, uri, url: url, servings: servings, calories: calories, healthLabels: healthLabels, digest: digest)

    return recipe
  end
end
