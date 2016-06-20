FactoryGirl.define do
  factory :product_nodes do
    title { FFaker::Product.product_name }
    maker { FFaker::Company.name }
    sku { (rand() * 1000000).to_i }
    price { (rand() * 100).to_f }
  end
end
