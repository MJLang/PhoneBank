module Internal
  class MembershipsController < BaseController
    before_filter :ensure_logged_in
    before_filter :find_team
    before_filter :find_membership, only: [:destroy]

    def create
      @team.add_member(current_user)
      redirect_to team_path(@team), success: "Joined Team #{@team.name}"
    end

    def destroy
      @team.drop_member(current_user)
      redirect_to team_path(@team), success: "Left Team #{@team.name}"
    end

    private

    def find_team
      @team = Team.find(params[:team_id])
    end

    def find_membership
      @membership = Membership.find(params[:id])
    end

    def can_destroy
      if @membership.nil?
        redirect_to internal_root_path, error: "You can't do that"
      end
    end
  end
end
