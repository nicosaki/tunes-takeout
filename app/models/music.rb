class Music
  SPOTIFY_URL = "https://api.spotify.com"

  def initialize(music)
    @music = music
  end

  def self.retrieve(id, type)
    if type.downcase == "track"
      music = RSpotify::Track.find(id)
    elsif type.downcase == "album"
      music = RSpotify::Album.find(id)
    elsif type.downcase == "artist"
      music = RSpotify::Artist.find(id)
    else
      music = "OTHER TYPE"
    end
    # music = HTTParty.get(SPOTIFY_URL + "/v1/#{type}/#{id}").parsed_response
    Music.new(music)
  end
end
