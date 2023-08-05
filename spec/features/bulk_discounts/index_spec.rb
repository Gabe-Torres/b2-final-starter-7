require "rails_helper"


describe "merchant bulk discounts index" do
  before :each do
    @merchant = create(:merchant)
    @bulk_discount1 = create(:bulk_discount, merchant: @merchant, percentage: "20%", quantity_threshold: 10, id: 1)
    @bulk_discount2 = create(:bulk_discount, merchant: @merchant, percentage: "50%", quantity_threshold: 60, id: 2)
    @bulk_discount3 = create(:bulk_discount, merchant: @merchant, percentage: "30%", quantity_threshold: 40, id: 3)
    @bulk_discount4 = create(:bulk_discount, merchant: @merchant, percentage: "20%", quantity_threshold: 25, id: 4)
  end
  it "has a link when visiting merchant dashboard and when clicked i am taken to the bd index" do 
    visit merchant_dashboard_index_path(@merchant)
    find_link "View All Discounts"
    click_link "View All Discounts"
    
    expect(current_path).to eq("/merchants/#{@merchant.id}/bulk_discounts")
  end
  
  scenario "I see all my b-discounts including their percentage/quantity, and each bd includes a link to its show page" do
    visit merchant_bulk_discounts_path(@merchant)
    
    expect(page).to have_content(@bulk_discount1.percentage)
    expect(page).to have_content(@bulk_discount3.quantity_threshold)
    expect(page).to have_link("Bulk Discount ##{@bulk_discount1.id}")
    expect(page).to have_link("Bulk Discount ##{@bulk_discount4.id}")
  end
end
