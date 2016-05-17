class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    #probs not right - direct link on layout/nav?
    render '/auth/spotify'
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash["uid"]
      @user = User.find_or_create_from_omniauth(auth_hash)
      if @user
        session[:user_id] = user.id
        redirect_to root_path
      else
        redirect_to root_path, notice: "Failed to save the user"
      end
    else
      redirect_to root_path, notice: "Failed to save the user"
    end
  end


  def destroy
    session.delete :user_id
    redirect_to root_path
  end

end
