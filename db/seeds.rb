# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

@merchant = Merchant.create!(id: 10000, name: "Test")

@bulk_discount1 = BulkDiscount.create!(merchant: @merchant, percentage: "20%", quantity_threshold: 10)
@bulk_discount2 = BulkDiscount.create!(merchant: @merchant, percentage: "30%", quantity_threshold: 20)
@bulk_discount3 = BulkDiscount.create!(merchant: @merchant, percentage: "40%", quantity_threshold: 30)
@bulk_discount4 = BulkDiscount.create!(merchant: @merchant, percentage: "50%", quantity_threshold: 40)

