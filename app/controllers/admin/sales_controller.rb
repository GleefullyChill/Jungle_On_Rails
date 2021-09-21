class Admin::SalesController < ApplicationController
  include HttpAuthConcern
  def index
    @sales = Sale.all
  end
end
