require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with a name, price, quantity, and a proper category" do
      @name = "Sloppy Joes"
      @price = 500.25
      @quantity = 5
      @category = Category.create(:name => "Carpentry")
      product = Product.new(name: @name, price: @price, quantity: @quantity, category: @category)
    end
    it "is not valid without a name" do
      product = Product.new(name: nil)
      expect(product).to_not be_valid
    end
    it "is not valid without a price" do
      product = Product.new(price: nil)
      expect(product).to_not be_valid
    end
    it "is not valid without a quantity" do
      product = Product.new(quantity: nil)
      expect(product).to_not be_valid
    end
    it "is not valid without a category" do
      product = Product.new(category: nil)
      expect(product).to_not be_valid
    end
  end
end
