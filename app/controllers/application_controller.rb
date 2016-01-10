class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    warden.user
  end
  helper_method :current_user

  def warden
    env['warden']
  end

  def ensure_logged_in
    if !current_user
      flash[:error] = "You need to be logged in"
      redirect_to root_path
    end
  end
end
