class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning
  helper_method :current_user

  private
  def current_user
    token = session[:user_token]
    unless token
      flash[:success] = 'Please login or Sign Up before proceeding!'
    end
    token
  end

end
