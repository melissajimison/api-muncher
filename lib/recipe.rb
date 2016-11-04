class Recipe
  attr_reader :label, :image, :uri, :ingredients, :url, :servings, :calories, :healthLabels, :digest

    def initialize(label, image, uri, options = {})
      if label == nil || label == "" || image == nil || uri == nil || uri == ""
        raise ArgumentError
      end

      @label = label
      @image = image
      #Store the uri after the underscore character. All characters before the underscore is a fix url
      @uri = uri[uri.index('_')+1..-1]

      @ingredients = options[:ingredients]
      @url = options[:url]
      @servings = options[:servings]
      @calories = options[:calories]
      @healthLabels = options[:healthLabels]
      @digest = options[:digest]
    end

    def calories_per_serving
      if @servings <= 0
        raise Error
      end

      return (@calories/@servings).round(0)
    end

    def nutrient(digest_hash)
      if @servings <= 0
        raise Error
      end

      nutrient = digest_hash["total"]/@servings

      return nutrient.round(0)
    end

    def daily_percentage(digest_hash)
      if @servings <= 0
        raise Error
      end
      
      return (digest_hash["daily"]/@servings).round(0)
    end
end
