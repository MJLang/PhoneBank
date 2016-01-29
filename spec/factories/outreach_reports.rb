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

FactoryGirl.define do
  factory :outreach_report do
    text_messages { rand(50) }
    phone_calls { rand(100) }
    comments { FFaker::Lorem.paragraph }
    experience { FFaker::Lorem.paragraph }
    report_type_id { ReportType.all.collect(&:id).sample }
    created_at { Time.at((Time.now.to_f - (Time.now - 20.days).to_f)*rand + (Time.now - 20.days).to_f) }
  end

end
