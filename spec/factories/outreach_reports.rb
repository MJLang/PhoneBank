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
#

FactoryGirl.define do
  factory :outreach_report do
    user nil
text_messages 1
phone_calls 1
comments "MyText"
experience "MyText"
  end

end
