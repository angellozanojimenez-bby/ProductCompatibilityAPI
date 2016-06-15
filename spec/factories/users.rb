FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password { password = FFaker::Internet.password }
    password_confirmation { password }
    employee_number { (rand() * 1000000).to_i }
  end
end
