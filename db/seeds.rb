# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Divisions

['Reddit', 'Collegiate'].each do |division|
  exisiting_division = Division.find_by(name: division)
  if exisiting_division.nil?
    Division.create({name: division})
  end
end

# Report Types
[{name: 'VoterID', phone_call_weight: 1, text_message_weight: 0.3},
 {name: 'GroundControl', phone_call_weight: 4, text_message_weight: 3}
].each do |report_type|
  existing_report = ReportType.find_by(name: report_type[:name])
  if existing_report.nil?
    ReportType.create(report_type)
  end
end

if Rails.env == "development"
  50.times do
    FactoryGirl.create(:user, :with_reports, reports_count: rand(50))
  end

  30.times do
    user = FactoryGirl.create(:user_with_team_admin)

    team = user.team
    team.division = Division.all.sample
    team.save

    rand(20).times do
      FactoryGirl.create(:user, :with_reports, reports_count: rand(10), team: team)
    end
  end
end
