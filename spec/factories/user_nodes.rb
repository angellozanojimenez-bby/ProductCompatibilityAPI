FactoryGirl.define do
  factory :user_nodes do
    email { FFaker::Internet.email }
    password { "password123" }
    password_confirmation { "password123" }
    employee_number { (rand() * 1000000).to_i }
    employee_score { (rand() * 1000).to_i }
  end
end
