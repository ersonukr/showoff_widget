class SessionsController < ApplicationController

  before_action :current_user, only: :destroy

  def new
  end

  def create
    outcome = Auth::Login.run(username: params[:email], password: params[:password])
    if outcome.valid?
      session[:user_email] = params[:email]
      session[:user_token] = outcome.result.dig('data', 'token', 'access_token')
      redirect_to root_url, notice: 'Logged in!'
    else
      flash[:alert] = 'Oops! Unable to login'
      redirect_to root_url
    end
  end

  def destroy
    Auth::Logout.run(token: session[:user_token])
    reset_session
    flash[:notice] = 'Logged out!'
    redirect_to root_url
  end
end
