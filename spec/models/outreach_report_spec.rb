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

require 'rails_helper'

RSpec.describe OutreachReport, type: :model do
  let(:report) { FactoryGirl.create(:outreach_report) }

  describe '#score' do
    it 'calculates the score of the report' do
      expect(report.score).to_not eq(0)
    end
  end
end
