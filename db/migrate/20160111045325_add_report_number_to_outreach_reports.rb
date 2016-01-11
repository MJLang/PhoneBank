class AddReportNumberToOutreachReports < ActiveRecord::Migration
  def change
    add_column :outreach_reports, :report_number, :integer
  end
end
