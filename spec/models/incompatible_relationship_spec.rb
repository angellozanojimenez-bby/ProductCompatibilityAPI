require 'spec_helper'

describe IncompatibleRelationships do
  let(:incompatible_relationship) { FactoryGirl.build :incompatible_relationships }

  subject { incompatible_relationship }

  it { should respond_to(:primary_node_sku) }
  it { should respond_to(:secondary_node_sku) }
  it { should respond_to(:employee_number) }
  it { should respond_to(:notes) }

  it { should validate_presence_of(:primary_node_sku) }
  it { should validate_presence_of(:secondary_node_sku) }
  it { should validate_presence_of(:employee_number) }
  it { should validate_presence_of(:notes) }
end
