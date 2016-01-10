# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  admin      :boolean          default(FALSE)
#  user_id    :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :membership do
    admin false 
  end

end
