class ProductNodes
  # We now have Neo4j set as our default database.
  # The command line command "rails g model ProductNode title:string, maker:string, sku:integer"
  # created this model.
  include Neo4j::ActiveNode
  property :title, type: String
  property :maker, type: String
  property :sku, type: Integer
  property :price, type: Float

  validates :title, :maker, :sku, :price, :presence => true
  validates :sku, numericality: { only_integer: true }
  validates :sku, :uniqueness => true

end
