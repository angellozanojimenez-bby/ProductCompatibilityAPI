FactoryGirl.define do
  factory :product do
    title { FFaker::Product.product_name }
    maker "Best Buy."
    sku_number { rand().to_i * 100}
  end
end
