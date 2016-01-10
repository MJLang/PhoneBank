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

require 'rails_helper'

RSpec.describe Membership, type: :model do
end
