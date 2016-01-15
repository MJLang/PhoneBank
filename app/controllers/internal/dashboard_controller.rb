module Internal
  class DashboardController < BaseController
    def index
      @reports = OutreachReport.where({user: current_user}).order('created_at DESC').page(params[:page]).per(2)
    end
  end
end
