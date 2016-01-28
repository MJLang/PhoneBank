class RankWorker
  include Sidekiq::Worker

  def perform
    redis = Redis.new
    Division.all.each do |division|
      ranked_teams = Team.divisional(division).ranked.to_a.collect(&:to_ranking)
      weekly_rankings = Team.divisional(division).weekly_ranked.to_a.collect(&:to_ranking)
      redis.set("teams:ranked:total:#{division.name.downcase}", Marshal.dump(ranked_teams))
      redis.set("teams:ranked:total:#{division.name.downcase}", Marshal.dump(weekly_rankings))

    end

    ranked_user = User.ranked.to_a.collect(&:to_ranking)
    weekly_user = User.weekly_ranked.to_a.collect(&:to_ranking)
    redis.set('user:ranked:total', Marshal.dump(ranked_user))
    redis.set('user:ranked:weekly', Marshal.dump(weekly_user))
  end
end
