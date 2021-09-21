require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid with a name, price, quantity, and a proper category" do
      @name = "Sloppy Joes"
      @price = 500.25
      @quantity = 5
      @category = Category.create(:name => "Carpentry")
      @product = Product.new(name: @name, price: @price, quantity: @quantity, category: @category)
      expect(@product).to be_valid
    end

    it "is not valid without a name" do
      @price = 500.25
      @quantity = 5
      @category = Category.create(:name => "Carpentry")
      @product = Product.new(price: @price, quantity: @quantity, category: @category)
      expect(@product).to_not be_valid
    end

    it "is not valid without a price" do
      @name = "Sloppy Joes"
      @quantity = 5
      @category = Category.create(:name => "Carpentry")
      @product = Product.new(name: @name, quantity: @quantity, category: @category)
      expect(@product).to_not be_valid
    end

    it "is not valid without a quantity" do
      @name = "Sloppy Joes"
      @price = 500.25
      @category = Category.create(:name => "Carpentry")
      @product = Product.new(name: @name, price: @price, category: @category)
      expect(@product).to_not be_valid
    end

    it "is not valid without a category" do
      @name = "Sloppy Joes"
      @price = 500.25
      @quantity = 5
      @product = Product.new(name: @name, price: @price, quantity: @quantity)
      expect(@product).to_not be_valid
    end
  end
end
