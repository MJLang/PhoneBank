class RankingsController < ApplicationController
  def index
    @rankings = Ranking.CACHE_KEYS.map
  end
end
