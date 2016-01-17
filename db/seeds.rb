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
