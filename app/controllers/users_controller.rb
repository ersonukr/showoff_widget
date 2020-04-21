class UsersController < ApplicationController

  def new
  end

  def create
    outcome = Users::Registration.run({user: user_params.to_hash})
    if outcome.valid?
      session[:user_email] = outcome.result.dig('data', 'user', 'email')
      session[:user_token] = outcome.result.dig('data', 'token', 'access_token')
      flash[:success] = 'Successfully sign up'
    else
      flash[:alert] = outcome.errors.messages.dig(:registration).first[:message]
    end
    redirect_to widgets_path
  end

  def reset_password
    unless request.get?
      outcome = Users::ResetPassword.run({user: params[:user]})
      if outcome.valid?
        reset_session
        flash[:success] = outcome.result['message']
      else
        flash[:alert] = 'Unable to process! Please Try again.'
      end
      redirect_to root_path
    end
  end

  private
  def user_params
    params[:user].permit(:first_name, :last_name, :email, :password, :image_url)
  end
end
