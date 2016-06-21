FactoryGirl.define do
  factory :user_nodes do
    email { FFaker::Internet.email }
    password { password = FFaker::Internet.password }
    password_confirmation { password }
    employee_number { (rand() * 1000000).to_i }
    employee_score { (rand() * 1000).to_i }
  end
end
