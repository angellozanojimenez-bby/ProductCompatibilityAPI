FactoryGirl.define do
  factory :product do
    title { FFaker::Product.product_name }
    maker { FFaker::Company.name }
    sku_number { (rand() * 1000000).to_i }
  end
end
