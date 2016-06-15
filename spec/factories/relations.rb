FactoryGirl.define do
  factory :relation do
    relations = ["works_with", "does_not_work_with"]
    sku_one { (rand() * 1000000).to_i }
    sku_two { (rand() * 1000000).to_i }
    relation_type { relations[(rand() * 2).floor] }
  end
end
