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
  def new
    @team = Team.new
  end

  def create
    team = Team.new(team_params)
    if team.save
      flash[:notice] = "Successfully created Team #{team.name}"
      redirect_to team_path(team)
    else
      flash.now[:error] = 'Could not create Team!'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :fundraising_url)
  end
end
