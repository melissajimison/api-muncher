require 'test_helper'
require 'edamamapiwrapper'

class EdamamApiWrapperTest < ActionController::TestCase
  #just to verify that Rake can pick up the test_helper
  test "the truth" do
    assert true
  end

  test "you must provide a keyword for the search" do
    assert_raises ArgumentError do
      EdamamApiWrapper.search_recipes nil, 1
    end

    assert_raises ArgumentError do
      EdamamApiWrapper.search_recipes "", 1
    end
  end

  test "search_recipes returns a valid response" do
    VCR.use_cassette("valid-response") do
      recipes = EdamamApiWrapper.search_recipes("pork", 1)
      assert recipes.is_a? Hash
      assert recipes.length > 0

      recipes = EdamamApiWrapper.search_recipes("pork", 0)
      assert recipes.is_a? Hash
      assert recipes.length > 0

      recipes = EdamamApiWrapper.search_recipes("pork", nil)
      assert recipes.is_a? Hash
      assert recipes.length > 0
    end
  end

  test "get_recipe returns a valid inquiry" do
    VCR.use_cassette("valid-recipe") do
      recipe = EdamamApiWrapper.get_recipe("e2cbaaf0f6b3aaea8d90dcb4c673c50d")
      assert_equal recipe.label, "Grilled Pork Loin"
    end
  end

end
