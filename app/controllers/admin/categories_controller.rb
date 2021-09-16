class Admin::CategoriesController < ApplicationController
  include HttpAuthConcern
  def index
    @categories = Category.all
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to [:admin, :category], notice: 'category deleted!'
  end
end
