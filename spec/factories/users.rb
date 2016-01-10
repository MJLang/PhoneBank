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
#

FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    last_login { DateTime.now }
  end
end
