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

FactoryGirl.define do
  factory :team do
    name { FFaker::Internet.user_name }
    description { FFaker::Lorem.paragraph }
    fundraising_url { FFaker::Internet.http_url }
  end

end
