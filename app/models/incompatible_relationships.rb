class IncompatibleRelationships
  # Instead of using ActiveNode, we use ActiveRel to state that this model
  # is to define IncompatibleRelationships relationships between two products.
  include Neo4j::ActiveRel
  before_save :do_this

  from_class :ProductNodes
  to_class :ProductNodes
  type 'does_not_work_with'

  property :employee_number, type: Integer
  property :notes
  property :primary_node_sku_or_upc, type: Integer
  property :secondary_node_sku_or_upc, type: Integer

  validates_presence_of :employee_number
  validates_presence_of :primary_node_sku_or_upc
  validates_presence_of :secondary_node_sku_or_upc

  def do_this
    # A callback to something.
  end
end
