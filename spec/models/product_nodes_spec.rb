require 'spec_helper'

describe ProductNodes do
  let(:product_node) { FactoryGirl.build :product_nodes }

  subject { product_node }

  it { should respond_to(:title) }
  it { should respond_to(:maker) }
  it { should respond_to(:sku_number) }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
  it { should validate_presence_of(:maker) }
  it { should validate_presence_of(:sku_number) }
  it { should validate_uniqueness_of(:sku_number) }
  it { should validate_numericality_of(:sku_number).is_greater_than_or_equal_to(0) }

end
