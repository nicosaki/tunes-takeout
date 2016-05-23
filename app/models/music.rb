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
    if type == "album"
      return music.images[0]
    elsif type == "artist"
      if music.images == []
        return {"url" => "http://localhost:3000/assets/artist_image.jpg"}
      else
        return music.images
      end
    elsif type == "track"
      return music.album.images[0]
    else
      return "WHAT DO?!"
    end
  end
end
