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
#

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      warden.set_user(user)
      redirect_to root_path, notice: 'Welcome!'
    else
      redirect_to register_path, error: 'Email already in use!'
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
