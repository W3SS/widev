class CreateTimeReasons < ActiveRecord::Migration
  def change
    create_table :time_reasons do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
