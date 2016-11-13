class MyrecipesController < ApplicationController
  before_action :validate_user_tasks, only: [:show, :destroy]

  def show
  end

  def destroy
  end
end
