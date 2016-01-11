module Internal
  class TeamsController < BaseController
    before_action :can_edit, only: [:edit, :update]
    before_action :already_in_team, only: [:new, :create]

    def new
      @team = Team.new
    end

    def create
      @team = Team.new(team_params)
      @team.memberships.new({user: current_user, admin: true})
      if @team.save
        redirect_to team_path(@team), notice: "Successfully created #{@team.name}"
      else
        flash.now[:error] = "Unable to create team"
        render 'new'
      end
    end

    def edit
      @team = current_user.team
    end

    def update
    end




    private

    def can_edit
      team = Team.find(params[:id])
      current_user.is_admin?(team)
    end

    def already_in_team
      unless current_user.team.nil?
        redirect_to team_path(current_user.team), error: 'You are already in a team'
      end
    end

    def team_params
      params.require(:team).permit(:name, :description, :division_id, :fundraising_url)
    end

  end
end
