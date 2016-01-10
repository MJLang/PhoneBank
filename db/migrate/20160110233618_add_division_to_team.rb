class AddDivisionToTeam < ActiveRecord::Migration
  def change
    add_reference :teams, :division, index: true, foreign_key: true
  end
end
