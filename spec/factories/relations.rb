FactoryGirl.define do
  factory :relation do
    sku_one { rand().to_i * 100 }
    sku_two { rand().to_i * 100 }
    relation_type "works_with"
  end
end
