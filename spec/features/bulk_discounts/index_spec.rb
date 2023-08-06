require "rails_helper"


describe "merchant bulk discounts index" do
  before :each do
    @merchant = create(:merchant)
    @bulk_discount1 = create(:bulk_discount, merchant: @merchant, percentage: "20%", quantity_threshold: 10)
    @bulk_discount2 = create(:bulk_discount, merchant: @merchant, percentage: "50%", quantity_threshold: 60)
    @bulk_discount3 = create(:bulk_discount, merchant: @merchant, percentage: "30%", quantity_threshold: 40)
    @bulk_discount4 = create(:bulk_discount, merchant: @merchant, percentage: "10%", quantity_threshold: 25)
  end

  scenario "has a link when visiting merchant dashboard and when clicked i am taken to the bd index" do 
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

  scenario "there is an option to create a new bulk discount but it must have valid data" do 
    visit merchant_bulk_discounts_path(@merchant)

    find_link "Enter New Bulk Discount"
    click_link "Enter New Bulk Discount"

    fill_in :percentage, with: "25%"
    fill_in :quantity_threshold, with:""

    click_button("Sumit New Bulk Discount")

    expect(page).to have_content("Error: percentage or quantity threshold enter incorrectly")
  
    fill_in :percentage, with: "25%"
    fill_in :quantity_threshold, with: 10

    click_button("Sumit New Bulk Discount")

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))

    expect(BulkDiscount.last.percentage).to eq("25%")
    expect(BulkDiscount.last.quantity_threshold).to eq(10)
    expect(BulkDiscount.last.merchant).to eq(@merchant)
  end

  scenario "next to each bulk discount there is a link to delete it" do 
    visit merchant_bulk_discounts_path(@merchant)

    expect(BulkDiscount.count).to eq(4)
    expect(page).to have_link("Delete ##{@bulk_discount4.id}")
    
    click_link "Delete ##{@bulk_discount4.id}"
      
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    expect(page).to_not have_link("Delete ##{@bulk_discount4.id}")
    expect(BulkDiscount.count).to eq(3)
  end
end
