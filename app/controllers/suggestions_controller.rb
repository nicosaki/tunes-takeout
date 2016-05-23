# require '/lib/tunes_takeout_wrapper'
class SuggestionsController < ApplicationController
  skip_before_action :require_login, only: :index

  def index
    @suggestions = extract_suggestions(TunesTakeoutWrapper.top(4))
    #shows top 20 suggestions, ranked by total number of favorites
    @user = current_user
    # if current_user
    #   @favorites = TunesTakeoutWrapper.user_favorites(@user.user_id)
    # end
  end

  def favorites #display user favorites
    @user = current_user
    @suggestions = TunesTakeoutWrapper.user_favorites(@user.uid)
    unless @suggestions.suggestions ==[]
      @suggestions = extract_suggestions(@suggestions) #returns array of pairing id's, FIX CALL
    end
  end

  def favorite
    @user = current_user
    @path = params[:path]
    @suggestion_id = params[:format]
    @suggestion = TunesTakeoutWrapper.favorite(@user.uid, @suggestion_id)
    redirect_to favorites_path(current_user.uid)#path.to_sym
  end

  def unfavorite
    @user = current_user
    @suggestion_id = params[:format]
    @suggestion = TunesTakeoutWrapper.unfavorite(@user.uid, @suggestion_id)
    @path = params[:path]
    redirect_to favorites_path(current_user.uid)# path.to_sym
  end

  def search
    @user = current_user
    @suggestions = TunesTakeoutWrapper.limited_search(params[:query], 4).suggestions
    @suggestions = extract_suggestions(@suggestions)
    render :results
  end



# favorites: shows all suggestions favorited by the signed-in User
# favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
# unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
end
