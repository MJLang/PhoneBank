# == Schema Information
#
# Table name: teams
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :string
#  fundraising_url :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  division_id     :integer
#

class Team < ActiveRecord::Base
  has_many :memberships, dependent: :delete_all
  has_many :members, through: :memberships, source: 'user'
  has_many :outreach_reports

  belongs_to :division

  validates :name, uniqueness: true,
                   presence: true
  scope :divisional, ->(division) { where({division: division}) }

  scope :ranked, -> {
                      includes(:outreach_reports => :report_type)
                      .sort { |a, b| b.total_score <=> a.total_score }
                      # .take(20)
                      # TODO: This in SQL
                      # .order('((sum(outreach_reports.phone_calls) * outreach_reports.report_types.phone_call_weight) +
                      #         (sum(outreach_reports.text_messages) * outreach_reports.report_types.text_message_weight)) DESC')
                    }

  scope :weekly_ranked, -> {
                            includes(:outreach_reports => :report_type)
                            .sort { |a, b| b.weekly_score <=> a.weekly_score }
                            # .take(20)
                           }

  def add_member(user)
    members << user
  end

  def total_score
    outreach_reports.includes(:report_type).to_a.sum(&:score)
  end

  def weekly_score
    outreach_reports.includes(:report_type).this_week.to_a.sum(&:score)
  end

  def add_admin(user)
    memberships.create({user: user, admin: true})
  end

  def has_member?(user)
    members.include?(user)
  end

  def has_admin?(user)
    memberships.includes(:user).where({admin: true}).collect(&:user).include?(user)
  end

  def drop_member(user)
    return false if !self.has_member?(user)
    membership = memberships.find_by({user: user})
    membership.destroy
    true
  end

  def to_ranking
    Ranking.new({weekly_score: weekly_score, total_score: self.total_score, display_name: self.name, id: self.id, record_type: 'Team'})
  end

end
