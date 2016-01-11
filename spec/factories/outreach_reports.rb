# == Schema Information
#
# Table name: outreach_reports
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  text_messages :integer
#  phone_calls   :integer
#  comments      :text
#  experience    :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  report_number :integer
#

FactoryGirl.define do
  factory :outreach_report do
    text_messages { rand(50) }
    phone_calls rand(100)
    comments { FFaker::Lorem.paragraph }
    experience { FFaker::Lorem.paragraph }
  end

end
