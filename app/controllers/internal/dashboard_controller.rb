module Internal
  class DashboardController < BaseController
    def index
      @reports = OutreachReport.where({user: current_user})
    end
  end
end
