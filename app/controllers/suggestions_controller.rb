class SuggestionsController < ApplicationController

  def index
    #shows top 20 suggestions, ranked by total number of favorites
  end
favorites: shows all suggestions favorited by the signed-in User
favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
end
