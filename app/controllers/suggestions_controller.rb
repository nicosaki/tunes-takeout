# require '/lib/tunes_takeout_wrapper'
class SuggestionsController < ApplicationController
  skip_before_action :require_login, only: :index
  def index
    @top = TunesTakeoutWrapper.top(4)
    #shows top 20 suggestions, ranked by total number of favorites
    @user = current_user
    # if current_user
    #   @favorites = TunesTakeoutWrapper.user_favorites(@user.user_id)
    # end
  end

  def favorites #display user favorites
    @user = current_user
    @favorites = TunesTakeoutWrapper.user_favorites(@user.user_id) #returns array of pairing id's, FIX CALL
  end

  def favorite
    @user = current_user
    @suggestion = TunesTakeoutWrapper.favorite(@user.user_id, suggestion_id)
  end

  def unfavorite
    @user = current_user
    @suggestion = TunesTakeoutWrapper.unfavorite(@user.user_id, suggestion_id)
  end

  def search
    @user = current_user
    @suggestions = TunesTakeoutWrapper.search(params[:query]).suggestions
    @suggestions.each do |suggestion_hash|
      food = suggestion_hash["food_id"]
      suggestion_hash["food_id"]= Food.retrieve(food)
      suggestion_hash["music_id"] = Music.retrieve(suggestion_hash["music_id"], suggestion_hash["music_type"])
    end
    render :results
  end



# favorites: shows all suggestions favorited by the signed-in User
# favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
# unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
end
