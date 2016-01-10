class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :description
      t.string :fundraising_url

      t.timestamps null: false
    end
  end
end
