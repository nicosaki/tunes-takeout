require 'httparty'

class TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/"
  attr_reader :suggestions, :suggestion

  def initialize(data)
    if data["suggestions"]
      if data["suggestions"].class == Array
        @suggestions = data["suggestions"]
      else
        @suggestions = data["suggestions"].suggestions
      end
    elsif data["suggestion"]
      if data["suggestion"].class == Array|| data["suggestion"].class == Hash
        @suggestion = data["suggestion"]
      else
        @suggestion = data["suggestion"].suggestion
      end
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

  def self.favorite(user_id, suggestion_id)
    fave_request = HTTParty.post(BASE_URL + "/v1/users/#{user_id}/favorites",
    body: {"suggestion"=> "#{suggestion_id}"}.to_json,
    headers: {"Content-Type" => "application/json" })
    return fave_request.code
  end

  def self.unfavorite(user_id, suggestion_id)
    unfave_request = HTTParty.delete(BASE_URL + "/v1/users/#{user_id}/favorites",
    body: {"suggestion"=> "#{suggestion_id}"}.to_json,
    headers: {"Content-Type" => "application/json" })
    return unfave_request.code
  end

  def self.top(limit = 20)
    data = HTTParty.get(BASE_URL + "/v1/suggestions/top?limit=#{limit}").parsed_response
    self.new(data)
  end

end
