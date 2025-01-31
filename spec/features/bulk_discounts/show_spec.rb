require "rails_helper"


RSpec.describe "merchant bulk discounts show" do
  before(:each) do
    @merchant = create(:merchant)
    @bulk_discount1 = create(:bulk_discount, merchant: @merchant, percentage: 20, quantity_threshold: 10)
  end
  scenario "bulk discount show page displays quantity threshold and percentage discount" do 
    visit merchant_bulk_discount_path(@merchant, @bulk_discount1)
    
    expect(page).to have_content("Percentage Discount: #{@bulk_discount1.percentage}")
    expect(page).to have_content("Quantity Threshold: #{@bulk_discount1.quantity_threshold}")
  end

  scenario "there is a link to edit bulk disocounts, and when clicked the page redirects to a new edit page" do 
    visit merchant_bulk_discount_path(@merchant, @bulk_discount1)

    find_button("Edit")
    click_button("Edit")
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @bulk_discount1))
    
    expect(page).to have_field("Percentage", with: "20.0")
    expect(page).to have_field("Quantity threshold", with: 10)
    
    fill_in "bulk_discount[quantity_threshold]", with: 20
    
    click_button("submit")
    
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount1))
    expect(page).to have_content("Quantity Threshold: 20")
  end
end