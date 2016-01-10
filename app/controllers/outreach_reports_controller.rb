class OutreachReportsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    if user
      report = user.outreach_reports.new(report_params)
      report.save
      redirect_to root_path, notice: 'Report created, thank you!'
    else
      redirect_to root_path, error: 'Invalid User'
    end
  end

  private


  def report_params
    params.require(:outreach_report).permit(:phone_calls, :text_messages, :experience, :comments)
  end
end
