# require '/lib/tunes_takeout_wrapper'
class SuggestionsController < ApplicationController
  skip_before_action :require_login, only: :index
  def index
    #shows top 20 suggestions, ranked by total number of favorites
  end

  def favorites
    @user = #set user, and set user id
    @favorites = TunesTakeout.user_favorites(user_id) #returns array of pairing id's, FIX CALL
  end



# favorites: shows all suggestions favorited by the signed-in User
# favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
# unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
end
