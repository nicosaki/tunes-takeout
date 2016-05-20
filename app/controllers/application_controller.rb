class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :require_login

  def current_user
      @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to root_path
    end
  end

  def get_food(suggestions)
    if suggestions.count == 1
      food = Food.find(id)
    end
    food_array = []
    suggestions.each do |hash|
      hash["food_id"] = id
      food = Food.find(id)
      food_array << food
    end
    return food_array
  end

  def get_music(suggestions)
    if suggestions.count == 1
      music = Music.find(id)
    end
    music_array = []
    suggestions.each do |hash|
      hash["music_id"] = id
      music = Music.find(id)
      music_array << music
    end
    return music_array
  end
end
