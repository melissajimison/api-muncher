class Recipe
  attr_reader :label, :image, :uri, :ingredients, :url, :servings, :calories, :healthLabels, :digest

    def initialize(label, image, ingredients, uri, options = {})
      @label = label
      @image = image
      @ingredients = ingredients
      #Store the uri after the underscore character. All characters before the underscore is a fix url
      @uri = uri[uri.index('_')+1..-1]

      @url = options[:url]
      @servings = options[:servings]
      @calories = options[:calories]
      @healthLabels = options[:healthLabels]
      @digest = options[:digest]
    end

    def calories_per_serving
      return (@calories/@servings).round(0)
    end

    def nutrient(digest_hash)
      nutrient = digest_hash["total"]/@servings

      return nutrient.round(0)
    end

    def daily_percentage(digest_hash)
      return (digest_hash["daily"]/@servings).round(0)
    end
end
