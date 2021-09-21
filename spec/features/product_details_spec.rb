require 'rails_helper'

RSpec.feature "Visitor navigates to home pages", type: :feature, js: true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit product_path(1)

    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_css 'article.product-detail', count: 1
  end
end
