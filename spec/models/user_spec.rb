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
    let(:admin_user) { FactoryGirl.create(:user_with_team_admin) }

    it 'should return if user is admin' do
      expect(admin_user.is_admin?(admin_user.team)).to be_truthy
    end
  end

  describe 'scope: ranked' do
    it 'should be able to rank a user' do
      users = FactoryGirl.create_list(:user, 10, :with_reports, reports_count: 20)
      users_ranked = User.ranked.to_a
      expect(users_ranked[0].total_score > users_ranked[1].total_score ).to be_truthy
    end
  end
end
