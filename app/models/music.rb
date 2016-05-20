class Music
attr_reader :name, :artist, :url, :album, :music
  def initialize(music, type)
    @name = music.name
    @artist = music.artists unless type == "artist"
    @url = music.artists[0].external_urls["spotify"] unless type =="artist"
    # @tracks = music.tracks_cache
    @album = music.album unless type == "album"
    # @cover = cover_art(music)
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
    Music.new(music, type)
  end

  def cover_art(music)
    cover_art = music.images[0]["url"]
    # cover_art = music.images[1]["url"]
  end
end
