# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  last_login      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  display_name    :string
#  slug            :string
#  state           :string
#

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reports = @user.outreach_reports.order('created_at DESC').page(params[:page]).per(2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      warden.set_user(@user)
      redirect_to internal_root_path, notice: 'Welcome!'
    else
      if @user.error.messages[:display_name]
        flash.now[:error] = 'Display Name has been taken'
      else
        flash.now[:error] = 'Email already in use'
      end
      render 'new'
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :display_name)
  end
end
