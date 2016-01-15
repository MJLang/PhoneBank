class SessionsController < ApplicationController
  def new
  end

  def create
    warden.authenticate!
    redirect_to internal_root_path, notice: "Logged in!"
  end

  def destroy
    warden.logout
    redirect_to root_path
  end

end
