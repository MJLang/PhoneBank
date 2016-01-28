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

FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'secret'
    last_login { DateTime.now }
    sequence(:display_name) { |n| "#{FFaker::Internet.user_name}-#{n}"  }

    factory :user_with_team_admin  do
      transient do
        division_id nil
      end

      after(:create) do |user, evaluator|
        team = create(:team, division_id: evaluator.division_id)
        create(:membership, user: user, admin: true, team: team)
      end
    end

    trait :with_membership do
      association :team
    end

    trait :with_reports do
      transient do
        reports_count rand(20)
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:outreach_report, evaluator.reports_count, user: user, team: user.team)
      end
    end
  end
end
