# == Schema Information
#
# Table name: outreach_reports
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  text_messages  :integer
#  phone_calls    :integer
#  comments       :text
#  experience     :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  report_number  :integer
#  team_id        :integer
#  report_type_id :integer
#

class OutreachReport < ActiveRecord::Base
  paginates_per 10
  belongs_to :user
  belongs_to :team
  belongs_to :report_type
  before_create :add_counter

  validates :text_messages, presence: true
  validates :phone_calls, presence: true
  validates :user_id, presence: true
  validates :report_type_id, presence: true

  scope :this_week, -> { where('created_at > ?', DateTime.now.utc.beginning_of_week )}

  def add_counter
    self.report_number = self.user.outreach_reports.count + 1
  end

  def score
    phone_calls * report_type.phone_call_weight + text_messages * report_type.text_message_weight
  end
end
