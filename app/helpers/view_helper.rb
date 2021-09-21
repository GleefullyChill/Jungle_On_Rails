module ViewHelper
  def sold_out?(id)
    @product = Product.find(id)
    @product.quantity < 1
  end
end