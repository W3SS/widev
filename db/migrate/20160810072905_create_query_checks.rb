class CreateQueryChecks < ActiveRecord::Migration
  def change
    create_table :query_checks do |t|
      t.string :title
      t.integer :rpt_interval
      t.boolean :is_started
      t.boolean :is_paused
      t.text :statement
      t.integer :num_exec
      t.date :last_exec_dt

      t.timestamps null: false
    end
  end
end
