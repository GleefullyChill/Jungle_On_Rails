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

  scenario "They see an increase in the count beside the cart when they click on an 'add to cart'" do
    # ACT
    visit root_path
    find(".button_to", match: :first).click
    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_content('My Cart (1)')
  end
end
