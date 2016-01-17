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

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user)}
  describe '#generate_slug' do
    it "generates a slug for the user" do
      expect(user.slug).to eq(user.display_name.to_param)
    end
  end

  describe '#is_admin?' do
    let(:user) { FactoryGirl.create(:user_with_team_admin) }

    it 'should return if user is admin' do
      expect(user.is_admin?(user.team)).to be_truthy
    end
  end
end
