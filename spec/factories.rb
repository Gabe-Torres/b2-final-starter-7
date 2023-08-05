FactoryBot.define do
  factory :customer do
    first_name {Faker::Company.name}
    last_name {Faker::JapaneseMedia::Naruto.eye}
  end

  factory :invoice do
    status {[0,1,2].sample}
    # merchant
    # customer
  end

  factory :merchant do
    name { Faker::JapaneseMedia::Naruto.character }
    status { 1 }
    trait :false do
      status  { false }
    end
  end
  
  factory :item do
    name {Faker::Games::Zelda.item}
    description {Faker::Hacker.say_something_smart}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    # merchant
  end

  factory :transaction do

    credit_card_number {Faker::Number.number(digits:16)}
    credit_card_expiration_date {"04/27"}
    
    trait :success do
      result  { "success" }
    end

    trait :failed do
      result  { "failed" }
    end
  end

  factory :invoice_item do
    quantity {rand(1..10)}
    unit_price { Faker::Commerce.price }
  
    trait :shipped do
      status {"shipped"}
    end

    trait :packaged do
      status {"packaged"}
    end

    trait :pending do
      status {"pending"}
    end
  end

  factory :bulk_discount do
    percentage { "#{Faker::Number.between(from: 0, to: 100)}%" }
    quantity_threshold { Faker::Number.within(range: 1..10) }

  end
end

