class UserNodes
  # We now have Neo4j set as our default database.
  # The command line command "rails g model UserNode email:string, password:string,
  # password_confirmation:string, employee_number:integer, employee_score:integer"
  # created this model.
  include Neo4j::ActiveNode
  property :email, type: String
  property :password, type: String
  property :password_confirmation, type: String
  property :employee_number, type: String
  property :employee_score, type: Integer
  property :created_at, type: DateTime
  property :updated_at, type: DateTime

  validates :email, :password, :password_confirmation, :employee_number, :employee_score, :presence => true
  validates :employee_number, numericality: { only_integer: true }, :uniqueness => true

end
