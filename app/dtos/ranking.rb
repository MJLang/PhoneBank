class Ranking
  attr_accessor :weekly_score, :total_score, :display_name, :id, :record_type


  CACHE_KEYS = {
                 user_weekly: "user:ranked:weekly",
                 user_total: "user:ranked:total",
               }

  Division.all.each do |d|
    CACHE_KEYS["teams_ranked_#{d.name.downcase}_weekly".to_sym] = "teams:ranked:#{d.name.downcase}:weekly"
    CACHE_KEYS["teams_ranked_#{d.name.downcase}_total".to_sym] = "teams:ranked:#{d.name.downcase}:total"
  end

  def initialize(params = {})
    params.each { |key,value| instance_variable_set("@#{key}", value) }
    instance_variables.each {|var| self.class.send(:attr_accessor, var.to_s.delete('@'))}
  end


  def self.load(type)
    redis_key = CACHE_KEYS[type]
    raise ArgumentError, ":U#{type} is not a valid Key" unless redis_key
    redis = Redis.new
    dump = redis.get(redis_key)
    return [] unless dump
    Marshal.load(dump)
  end

  def self.load_all
    r = Redis.new
    rankings = {}
    CACHE_KEYS.map do |key, value|
      rankings[key] = self.load(key)
    end
    rankings
  end

  def self.CACHE_KEYS
    CACHE_KEYS
  end



end
