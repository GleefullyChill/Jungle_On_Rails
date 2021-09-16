class Admin::DashboardController < ApplicationController
  include HttpAuthConcern
  def show
    @count_products = Product.count
    @count_categories = Category.count
  end
end
