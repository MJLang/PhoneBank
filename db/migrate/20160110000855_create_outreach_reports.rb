class CreateOutreachReports < ActiveRecord::Migration
  def change
    create_table :outreach_reports do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :text_messages
      t.integer :phone_calls
      t.text :comments
      t.text :experience

      t.timestamps null: false
    end
  end
end
