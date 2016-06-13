require 'spec_helper'

describe Product do
  before { @product = FactoryGirl.build(:product) }

  subject { @product }

  it { should respond_to(:title) }
  it { should respond_to(:maker) }
  it { should respond_to(:sku_number) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:maker) }
  it { should validate_presence_of(:sku_number) }
  it { should validate_uniqueness_of(:sku_number) }

end
