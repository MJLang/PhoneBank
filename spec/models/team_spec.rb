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

require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { FactoryGirl.create(:team) }
  describe '#add_member' do
    it 'should add a user as a member' do
      user = FactoryGirl.create(:user)
      team.add_member(user)
      expect(team.members.count).to eq(1)
    end
  end

  describe "#has_member?" do
    let(:user) { FactoryGirl.create(:user) }

    it "user should not be a member" do
      expect(team.has_member?(user)).to be_falsey
    end

    it 'user should be a member' do
      team.members << user
      expect(team.has_member?(user)).to be_truthy
    end
  end

  describe '#has_admin?' do
    let(:user) { FactoryGirl.create(:user) }

    it 'user should not be a an admin' do
      expect(team.has_admin?(user)).to be_falsey
    end

    it 'user should be an admin' do
      membership = Membership.create({user: user, team: team, admin: true})
      expect(team.has_admin?(user)).to be_truthy
    end
  end

  describe '#drop_user' do
    let(:user) { FactoryGirl.create(:user) }
    it 'should be able to remove the user' do
      team.members << user

      team.drop_member(user)
      expect(team.members.count).to eq(0)
    end
  end
end
