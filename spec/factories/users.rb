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
  end
end
