require 'spec_helper'

describe Product do
  before { @product = FactoryGirl.build(:product) }

  subject { @product }

  it { should respond_to(:title) }
  it { should respond_to(:maker) }
  it { should respond_to(:sku_number) }

end
