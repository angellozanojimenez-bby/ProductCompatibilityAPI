require 'spec_helper'

describe Relation do
  before { @relation = FactoryGirl.build(:relation) }

  subject { @relation }

  it { should respond_to(:sku_one) }
  it { should respond_to(:sku_two) }
  it { should respond_to(:relation_type) }

end
