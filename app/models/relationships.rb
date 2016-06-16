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
  property :primary_node
  property :secondary_node

  validates_presence_of :employee_number

  def do_this
    # A callback to something.
  end
end
