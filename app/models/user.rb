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

class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true,
                    presence: true

  validates :display_name, uniqueness: true,
                           presence: true

  has_many :outreach_reports
  has_one :membership, dependent: :destroy
  has_one :team, through: :membership

  before_save :generate_slug

  scope :ranked, -> {
                      includes(outreach_reports: :report_type)
                      .sort { |a, b| b.total_score <=> a.total_score }
                      # .take(20)
                      # TODO: This in SQL
                      # .order('((sum(outreach_reports.phone_calls) * outreach_reports.report_types.phone_call_weight) +
                      #         (sum(outreach_reports.text_messages) * outreach_reports.report_types.text_message_weight)) DESC')
                    }

  scope :weekly_ranked, -> {
                            includes(outreach_reports: :report_type)
                            .sort { |a, b| b.weekly_score <=> a.weekly_score }
                            # .take(20)
                           }


  def self.top_ranked
    redis = Redis.new
    ranked_json = redis.get('user:ranked')
    if ranked_json
      ranked = JSON.parse(ranked_json)
      return ranked.map {|r| User.deserialize(r) }
    else
      RankWorker.perform_async
      return User.ranked.map {|u| User.find(u) }
    end
  end

  def self.deserialize(json)
    return User.find(json["id"])
  end

  def to_s
    display_name.nil? ? email : display_name
  end

  def generate_slug
    self.slug = display_name.to_param
  end

  def is_member?(team)
    self.team == team
  end

  def is_admin?(team)
    return false if self.team.nil?
    self.membership.admin == true
  end

  def total_score
    outreach_reports.includes(:report_type).to_a.sum(&:score)
  end

  def weekly_score
    outreach_reports.includes(:report_type).this_week.to_a.sum(&:score)
  end

  def serialize
    {id: id, name: display_name, total_score: self.total_score, weekly_score: weekly_score}
  end

  def to_ranking
    Ranking.new({weekly_score: weekly_score, total_score: self.total_score, display_name: self.to_s, id: self.id, record_type: 'User'})
  end



end
