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

class TeamsController < ApplicationController
  before_action :find_team, only: [:show]


  private

  def team_params
    params.require(:team).permit(:name, :description, :fundraising_url)
  end

  def find_team
    @team = Team.find(params[:id])
  end
end
