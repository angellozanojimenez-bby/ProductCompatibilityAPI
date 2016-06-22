class Relationships
  # Instead of using ActiveNode, we use ActiveRel to state that this model
  # is to define Relationships between two products.
  include Neo4j::ActiveRel
  before_save :do_this

  from_class :ProductNodes
  to_class :ProductNodes
  type 'works_with'

  property :employee_number, type: Integer
  property :notes
  property :primary_node_sku, type: Integer
  property :secondary_node_sku, type: Integer

  validates_presence_of :employee_number
  validates_presence_of :primary_node_sku
  validates_presence_of :secondary_node_sku

  def do_this
    # A callback to something.
  end
end
