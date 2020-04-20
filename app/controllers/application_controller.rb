class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning
  helper_method :current_user

  private
  def current_user
    session[:user_token]
  end

end
