class Recipe
  attr_reader :label, :image, :uri, :ingredients

    def initialize(label, image, ingredients, uri)
      @label = label
      @image = image
      @ingredients = ingredients

      #Store the uri after the underscore character. All characters before the underscore is a fix url
      @uri = uri[uri.index('_')+1..-1]
    end
end
