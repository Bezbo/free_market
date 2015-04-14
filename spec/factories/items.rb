FactoryGirl.define do
  factory :item do
    name Faker::Commerce.product_name
    description Faker::Lorem.paragraph
    user_id Faker::Number.digit
    address Faker::Address.city
  end

  factory :invalid_item, parent: :item do
    name nil
  end

end
