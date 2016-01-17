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
                      includes(:outreach_reports => :report_type)
                      .sort { |a, b| b.total_score <=> a.total_score }
                      # TODO: This in SQL
                      # .order('((sum(outreach_reports.phone_calls) * outreach_reports.report_types.phone_call_weight) +
                      #         (sum(outreach_reports.text_messages) * outreach_reports.report_types.text_message_weight)) DESC')
                    }

  scope :weekly_ranked, -> {
                            includes(:outreach_reports => :report_type)
                            .sort { |a, b| b.weekly_score <=> a.weekly_score }
                           }

                           
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
    outreach_reports.to_a.sum(&:score)
  end

  def weekly_score
    self.outreach_reports.this_week.to_a.sum(&:score)
  end



end
