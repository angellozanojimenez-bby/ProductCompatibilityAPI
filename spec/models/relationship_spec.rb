require 'spec_helper'

describe Relationship do
  let(:relationship) { FactoryGirl.build :relationship }

  subject { relation }

  it { should respond_to(:sku_one) }
  it { should respond_to(:sku_two) }
  it { should respond_to(:relation_type) }

  it { should validate_presence_of(:sku_one) }
  it { should validate_presence_of(:sku_two) }
  it { should validate_presence_of(:relation_type) }
