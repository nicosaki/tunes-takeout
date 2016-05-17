require 'httparty'

class TunesTakeout
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
  attr_reader :suggestions

  def initialize(data)
    if data["suggestions"]
      @suggestions = data["suggestions"]
    elsif data["suggestion"]
      @suggestion = data["suggestion"]
    else
      @errors = "No data returned"
    end
  end
  #
  # def favorite_move
  #   HTTParty.get(moves.sample["move"]["url"]).parsed_response
  # end

  def self.search(query)
    data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}").parsed_response
    self.new(data)
  end

  def self.limited_search(query, n)
    data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}&limit=#{n}").parsed_response
    self.new(data)
  end

  def self.random(query, n, seed = random(99999))
    data = HTTParty.get(BASE_URL + "/v1/suggestions/search?query=#{query}&limit=#{n}&seed=#{seed}").parsed_response
    self.new(data)
  end

  def self.specific_suggestion(suggestion_id)
    data = HTTParty.get(BASE_URL + "/v1/suggestions/#{suggestion_id}").parsed_response
    self.new(data)
  end

  def self.user_favorites(user_id) #returns "suggestions":["VzoxXvLQUmT7dPJ5", "VzoxXvLQUmT7dPJ6"]
    data = HTTParty.get(BASE_URL + "/v1/users/#{user_id}/favorites").parsed_response
    self.new(data)
  end

  private

end
