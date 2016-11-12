require 'test_helper'
require 'recipe'

class RecipeTest < ActionController::TestCase
  #just to verify that Rake can pick up the test_helper
  test "the truth" do
    assert true
  end

  test "you must provide a label, an image, and a uri for a Recipe" do
    assert_raises ArgumentError do
      Recipe.new nil, nil, nil
    end

    assert_raises ArgumentError do
      Recipe.new "", nil, nil
    end

    assert_raises ArgumentError do
      Recipe.new nil, "", nil
    end

    assert_raises ArgumentError do
      Recipe.new nil, nil, ""
    end
  end


end
