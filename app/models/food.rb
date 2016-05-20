class Food
attr_reader :food

  def initialize(food)
    @food = food
  end

  def self.retrieve(id)
    # food = HTTParty.get(YELP_URL + "/v2/business/#{id}")
    food = Yelp.client.business(id.parameterize).business
    Food.new(food)
  end
end
