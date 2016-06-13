class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end
  # Check for a match.
  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.productcompatibility.v#{@version}")
  end
end
