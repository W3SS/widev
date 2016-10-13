class CreateTimeTimeReports < ActiveRecord::Migration
  def change
    create_table :time_time_reports do |t|
      t.date :repdate
      t.float :hours
      t.string :note


      t.timestamps null: false
    end
    add_reference :time_time_reports , :user, index: true
  end
end
