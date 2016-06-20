require 'spec_helper'

describe UserNodes do
  before { @user_node = FactoryGirl.build(:user_nodes) }

  subject { @user_node }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:employee_number) }
  it { should respond_to(:employee_score) }
  # Checks for a valid email.
  it { should be_valid }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_presence_of(:employee_number) }
  it { should validate_uniqueness_of(:employee_number) }
  it { should validate_numericality_of(:employee_number).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:employee_score) }
  it { should validate_numericality_of(:employee_score).is_greater_than_or_equal_to(0) }
end
