# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Rake::Task["csv_load:all"].invoke
Merchant.destroy_all
Item.destroy_all
Customer.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all
Transaction.destroy_all
BulkDiscount.destroy_all



10.times do
  merchant = Merchant.create!(name: Faker::JapaneseMedia::Naruto.character, status: rand(0..1))

  3.times do
    bulk_discount = BulkDiscount.create!(percentage: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50].sample,
      quantity_threshold: rand(3..15),
      merchant: merchant)
  end

  6.times do
    item = Item.create!(name: Faker::Games::Zelda.item,
      description: Faker::Hacker.say_something_smart,
      unit_price: Faker::Number.decimal(l_digits: 2),
      merchant: merchant,
      status: rand(0..1))

    6.times do
      customer = Customer.create!(first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        address: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip)

      invoice = Invoice.create!(status: rand(0..2), customer: customer)

      invoice_item = InvoiceItem.create!(quantity: rand(1..10),
        unit_price: Faker::Commerce.price,
        status: rand(0..1),
        invoice: invoice,
        item: item)
    end
  end
end

8.times do
  invoice = Invoice.create!(status: rand(0..2),
    customer: Customer.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip: Faker::Address.zip))

  transaction = Transaction.create!(credit_card_number: Faker::Number.number(digits: 16),
    credit_card_expiration_date: Faker::Business.credit_card_expiry_date.strftime("%m%y"),
    result: rand(0..1),
    invoice: invoice)
end
