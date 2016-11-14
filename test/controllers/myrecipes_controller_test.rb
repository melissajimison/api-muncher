require 'test_helper'

class MyrecipesControllerTest < ActionController::TestCase

  test "should get destroy" do
    get :show
    assert_response :redirect
  end

end
