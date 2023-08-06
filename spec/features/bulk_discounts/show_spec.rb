require "rails_helper"


describe "merchant bulk discounts show" do
  before(:each) do
    @merchant = create(:merchant)
    @bulk_discount1 = create(:bulk_discount, merchant: @merchant, percentage: "20%", quantity_threshold: 10)
  end
  scenario "bulk discount show page displays quantity threshold and percentage discount" do 
    visit merchant_bulk_discount_path(@merchant, @bulk_discount1)
    
    expect(page).to have_content("Percentage Discount: #{@bulk_discount1.percentage}")
    expect(page).to have_content("Quantity Threshold: #{@bulk_discount1.quantity_threshold}")
  end
end