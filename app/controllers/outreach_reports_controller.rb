# == Schema Information
#
# Table name: outreach_reports
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  text_messages  :integer
#  phone_calls    :integer
#  comments       :text
#  experience     :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  report_number  :integer
#  team_id        :integer
#  report_type_id :integer
#

class OutreachReportsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    if user
      report = user.outreach_reports.new(report_params)
      if user.team
        report.team = user.team
      end
      if report.save
        redirect_to internal_root_path, notice: 'Report created, thank you!'
      else
        redirect_to internal_root_path, error: 'Something went wrong!'
      end
    else
      redirect_to internal_root_path, error: 'Invalid User'
    end
  end

  private


  def report_params
    params.require(:outreach_report).permit(:phone_calls, :text_messages, :experience, :comments, :report_type_id)
  end
end
