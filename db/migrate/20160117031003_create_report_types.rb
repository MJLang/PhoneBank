class CreateReportTypes < ActiveRecord::Migration
  def change
    create_table :report_types do |t|
      t.string :name
      t.decimal :phone_call_weight
      t.decimal :text_message_weight

      t.timestamps null: false
    end

    add_reference :outreach_reports, :report_type, index: true, foreign_key: true
  end
end
