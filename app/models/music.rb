class Music
attr_reader :name, :artist, :url, :album, :cover
  def initialize(music, type)
    @name = music.name
    @artist = music.artists unless type == "artist"
    @url = music.artists[0].external_urls["spotify"] unless type =="artist"
    # @tracks = music.tracks_cache
    @cover = cover_art(music, type)
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

  def cover_art(music, type)
    cover_art_array = []
    if type == "album" || type == "artist"
      return music.images
    else
      cover_arts = music.album.images
    end
    cover_arts.each do |cover|
      cover_art_array << cover["url"]
    end
    return cover_art_array
  end
end
