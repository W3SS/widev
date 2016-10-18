class CreateTimeFestivita < ActiveRecord::Migration
  def change
    create_table :time_festivita do |t|
      t.string :name
      t.float :forecast_val
      t.boolean :chargeable
      t.date :festdate

      t.timestamps null: false
    end
  end
end
