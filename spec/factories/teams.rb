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

    trait :with_reports do
      transient do
        reports_count 0
      end

      after(:create) do |team, evaluator|
        FactoryGirl.create_list(:outreach_report, evaluator.reports_count, team: team, user: create(:user))
      end
    end

    trait :with_division do
      before(:create) do |team, evaluator|
        team.division_id = evaluator.division_id || Division.all.collect(&:id).sample
      end
    end
  end

end
