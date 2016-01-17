class AddTeamIdToOutreachReport < ActiveRecord::Migration
  def change
    add_reference :outreach_reports, :team, index: true, foreign_key: true
  end
end
