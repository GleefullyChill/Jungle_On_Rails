class Admin::CategoriesController < ApplicationController
  include HttpAuthConcern
  def index
    @categories = Category.all
  end

  def new
    @categories = Categories.new
  end

  def create
    @categories = categories.new(categories_params)

    if @categories.save
      redirect_to [:admin, :categories], notice: 'Categories created!'
    else
      render :new
    end
  end
end
