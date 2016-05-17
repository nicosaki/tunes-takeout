class SessionsController < ApplicationController

  def new
    #invoke OAuth sign-in (link?)
    render :new
  end

  def create
    @spotify_user = 0 #spotify user information
    @user = @spotify_user.id ||= User.new(@spotify_user)
    session[:user_id] = @user.id
  end

  def destroy
    session[:user_id] = nil
  end

end
