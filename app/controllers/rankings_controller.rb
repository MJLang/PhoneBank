class RankingsController < ApplicationController
  def index
    @user_rankings_total = Ranking.load(:user_total).take(10)
    @user_rankings_weekly = Ranking.load(:user_weekly).take(10)
    p @user_rankings_weekly


  end

  def user
  end

  def teams
  end
end
