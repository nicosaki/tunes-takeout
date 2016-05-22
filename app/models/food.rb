class Food
attr_reader :food, :name, :address, :url, :rating, :image

  def initialize(food)
    @name = food.name
    @address = food.location
    @url = food.mobile_url
    @rating = food.rating_img_url
    @image = food.image_url
  end

  def self.retrieve(id)
    # food = HTTParty.get(YELP_URL + "/v2/business/#{id}")
    food = Yelp.client.business(id.parameterize).business
    Food.new(food)
  end
end
