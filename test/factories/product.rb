FactoryGirl.define do
  factory :product do
    category
    brand
    name { generate :string }
    price_cents { generate :integer }
  end
end
