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
      expect(team.members).to have(1).items
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
      expect(team.members).to have(0).items
    end
  end

  describe 'scope: ranked' do
    let(:team_with_report) { FactoryGirl.create(:team, :with_reports, reports_count: 5) }

    it 'has many reports' do
      expect(team_with_report.outreach_reports).to have(5).items
    end

    it 'ranks teams by how many phonecalls they made' do
      teams = FactoryGirl.create_list(:team, 10, :with_reports, reports_count: 20)
      teams_ranked = Team.ranked.to_a
      expect(teams_ranked[0].total_score > teams_ranked[1].total_score ).to be_truthy
    end
  end

  describe 'scope: divisional' do
    it 'filters by division' do
      division_team1 = FactoryGirl.create(:team, :with_division, division_id: 1)
      division_team2 = FactoryGirl.create(:team, :with_division, division_id: 2)

      expect(Team.divisional(1)).to have(1).items
    end
  end
end
