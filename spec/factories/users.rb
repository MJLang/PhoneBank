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
    display_name { FFaker::Internet.user_name  }

    factory :user_with_team_admin  do
      after(:create) do |user, evaluator|
        create(:membership, user: user, admin: true, team: create(:team))
      end
    end

    trait :with_reports do
      transient do
        reports_count 0
      end

      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:outreach_report, evaluator.reports_count, user: user)
      end
    end
  end
end
